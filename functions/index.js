const {onSchedule} = require("firebase-functions/v2/scheduler");
const {defineSecret} = require("firebase-functions/params");
const {logger} = require("firebase-functions");
const admin = require("firebase-admin");
const twilio = require("twilio");
const sendgridMail = require("@sendgrid/mail");

admin.initializeApp();
const db = admin.firestore();

const WHATSAPP_TOKEN = defineSecret("WHATSAPP_TOKEN");
const WHATSAPP_PHONE_NUMBER_ID = defineSecret("WHATSAPP_PHONE_NUMBER_ID");
const WHATSAPP_TEMPLATE_NAME = defineSecret("WHATSAPP_TEMPLATE_NAME");
const TWILIO_ACCOUNT_SID = defineSecret("TWILIO_ACCOUNT_SID");
const TWILIO_AUTH_TOKEN = defineSecret("TWILIO_AUTH_TOKEN");
const TWILIO_FROM = defineSecret("TWILIO_FROM");
const SENDGRID_API_KEY = defineSecret("SENDGRID_API_KEY");
const SENDGRID_FROM_EMAIL = defineSecret("SENDGRID_FROM_EMAIL");

const REMINDER_WINDOW_MINUTES = 1;
const EXACT_REMINDER_OFFSET_HOURS = 24;
const DISPLAY_TIME_ZONE = "Asia/Baghdad";

exports.processAppointmentReminders = onSchedule(
  {
    schedule: "every 1 minutes",
    timeZone: "UTC",
    region: "us-central1",
    secrets: [
      WHATSAPP_TOKEN,
      WHATSAPP_PHONE_NUMBER_ID,
      WHATSAPP_TEMPLATE_NAME,
      TWILIO_ACCOUNT_SID,
      TWILIO_AUTH_TOKEN,
      TWILIO_FROM,
      SENDGRID_API_KEY,
      SENDGRID_FROM_EMAIL,
    ],
  },
  async () => {
    const now = new Date();
    const clinicsSnapshot = await db.collection("clinics").get();
    logger.info(`Processing reminders for ${clinicsSnapshot.size} clinics.`);

    for (const clinicDoc of clinicsSnapshot.docs) {
      await processClinicReminders(clinicDoc.id, now);
    }
  },
);

async function processClinicReminders(clinicId, now) {
  const clinicSnapshot = await db.doc(`clinics/${clinicId}`).get();
  const clinic = clinicSnapshot.data() || {};
  const clinicName = toTrimmedString(clinic.name) || clinicId;

  const settingsRef = db.doc(`clinics/${clinicId}/settings/config`);
  const settingsSnapshot = await settingsRef.get();
  const settings = settingsSnapshot.data() || {};
  const reminderOffsetHours = EXACT_REMINDER_OFFSET_HOURS;

  const targetFrom = new Date(now.getTime() + reminderOffsetHours * 60 * 60 * 1000);
  const targetTo = new Date(
    targetFrom.getTime() + REMINDER_WINDOW_MINUTES * 60 * 1000,
  );

  const appointmentsSnapshot = await db
      .collection(`clinics/${clinicId}/appointments`)
      .where("startAt", ">=", targetFrom)
      .where("startAt", "<", targetTo)
      .where("status", "==", "scheduled")
      .get();

  logger.info(
      `Clinic ${clinicId}: found ${appointmentsSnapshot.size} appointments for reminder window.`,
  );

  for (const appointmentDoc of appointmentsSnapshot.docs) {
    const appointment = appointmentDoc.data();

    if (appointment.reminderSent === true) {
      continue;
    }

    const logId = `${appointmentDoc.id}_${reminderOffsetHours}`;
    const logRef = db.doc(`clinics/${clinicId}/reminderLogs/${logId}`);
    if ((await logRef.get()).exists) {
      continue;
    }

    const patientSnapshot = await db
        .doc(`clinics/${clinicId}/patients/${appointment.patientId}`)
        .get();
    const patient = patientSnapshot.data() || {};

    const appointmentDate = asDate(appointment.startAt);
    const patientName = appointment.patientName || patient.displayName || "Patient";
    const patientPhone = appointment.patientPhone || patient.phoneNumber || "";
    const patientEmail = patient.email || "";
    const appointmentReason = toTrimmedString(appointment.reason) || "visit";
    const messageText = buildReminderText({
      patientName,
      appointmentReason,
      scheduledText: formatScheduledDate(appointmentDate),
      clinicName,
    });

    const sendResult = await sendWithFallback({
      settings,
      patientPhone,
      patientEmail,
      messageText,
      patientName,
      appointmentDate,
    });

    await logRef.set({
      id: logId,
      clinicId,
      appointmentId: appointmentDoc.id,
      patientId: appointment.patientId,
      channel: sendResult.channel,
      status: sendResult.status,
      providerResponse: sendResult.providerResponse,
      scheduledFor: appointment.startAt,
      executedAt: admin.firestore.FieldValue.serverTimestamp(),
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    if (sendResult.status === "sent") {
      await appointmentDoc.ref.update({
        reminderSent: true,
        reminderSentAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
  }
}

async function sendWithFallback({
  settings,
  patientPhone,
  patientEmail,
  messageText,
  patientName,
  appointmentDate,
}) {
  const whatsappEnabled = settings.whatsAppEnabled !== false;
  const smsEnabled = settings.smsEnabled === true;
  const emailEnabled = settings.emailEnabled === true;

  if (whatsappEnabled && patientPhone) {
    const result = await sendViaWhatsApp({
      settings,
      phone: patientPhone,
      patientName,
      appointmentDate,
      messageText,
    });
    if (result.status === "sent") return result;
  }

  if (smsEnabled && patientPhone) {
    const result = await sendViaTwilio(patientPhone, messageText);
    if (result.status === "sent") return result;
  }

  if (emailEnabled && patientEmail) {
    const result = await sendViaSendGrid(patientEmail, messageText);
    if (result.status === "sent") return result;
  }

  return {
    status: "failed",
    channel: "none",
    providerResponse: "No reminder provider succeeded.",
  };
}

async function sendViaWhatsApp({
  settings,
  phone,
  patientName,
  appointmentDate,
  messageText,
}) {
  const token = WHATSAPP_TOKEN.value();
  const defaultPhoneNumberId = WHATSAPP_PHONE_NUMBER_ID.value();
  const clinicPhoneNumberId = toTrimmedString(settings.whatsAppPhoneNumberId);
  const phoneNumberId = clinicPhoneNumberId || defaultPhoneNumberId;
  const templateName = WHATSAPP_TEMPLATE_NAME.value() || "appointment_reminder";
  if (!token || !phoneNumberId) {
    return {
      status: "failed",
      channel: "whatsapp",
      providerResponse: "Missing WhatsApp token or phone number id.",
    };
  }

  const to = normalizePhone(phone);
  if (!to) {
    return {
      status: "failed",
      channel: "whatsapp",
      providerResponse: "Invalid phone number.",
    };
  }

  const appointmentText = formatScheduledDate(appointmentDate);

  try {
    const response = await fetch(
        `https://graph.facebook.com/v21.0/${phoneNumberId}/messages`,
        {
          method: "POST",
          headers: {
            "Authorization": `Bearer ${token}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            messaging_product: "whatsapp",
            to,
            type: "template",
            template: {
              name: templateName,
              language: {code: "ar"},
              components: [
                {
                  type: "body",
                  parameters: [
                    {type: "text", text: patientName},
                    {type: "text", text: appointmentText},
                    {type: "text", text: messageText},
                  ],
                },
              ],
            },
          }),
        },
    );

    const payload = await response.text();
    if (!response.ok) {
      return {
        status: "failed",
        channel: "whatsapp",
        providerResponse: payload,
      };
    }
    return {
      status: "sent",
      channel: "whatsapp",
      providerResponse: payload,
    };
  } catch (error) {
    return {
      status: "failed",
      channel: "whatsapp",
      providerResponse: String(error),
    };
  }
}

async function sendViaTwilio(phone, messageText) {
  const sid = TWILIO_ACCOUNT_SID.value();
  const token = TWILIO_AUTH_TOKEN.value();
  const from = TWILIO_FROM.value();

  if (!sid || !token || !from) {
    return {
      status: "failed",
      channel: "sms",
      providerResponse: "Missing Twilio secrets.",
    };
  }

  try {
    const client = twilio(sid, token);
    const result = await client.messages.create({
      body: messageText,
      from,
      to: phone,
    });
    return {
      status: "sent",
      channel: "sms",
      providerResponse: result.sid || "Twilio sent",
    };
  } catch (error) {
    return {
      status: "failed",
      channel: "sms",
      providerResponse: String(error),
    };
  }
}

async function sendViaSendGrid(email, messageText) {
  const apiKey = SENDGRID_API_KEY.value();
  const fromEmail = SENDGRID_FROM_EMAIL.value();
  if (!apiKey || !fromEmail) {
    return {
      status: "failed",
      channel: "email",
      providerResponse: "Missing SendGrid secrets.",
    };
  }

  try {
    sendgridMail.setApiKey(apiKey);
    await sendgridMail.send({
      to: email,
      from: fromEmail,
      subject: "Clinic MX Appointment Reminder",
      text: messageText,
    });
    return {
      status: "sent",
      channel: "email",
      providerResponse: "SendGrid sent",
    };
  } catch (error) {
    return {
      status: "failed",
      channel: "email",
      providerResponse: String(error),
    };
  }
}

function buildReminderText({
  patientName,
  appointmentReason,
  scheduledText,
  clinicName,
}) {
  return `السلام عليكم ${patientName} حضرتك عندك موعد زيارة ${appointmentReason}
في ${scheduledText} في ${clinicName} اخبرنا اذا لديك اي استفسار`;
}

function formatScheduledDate(appointmentDate) {
  return new Intl.DateTimeFormat("en-US", {
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
    hour12: true,
    timeZone: DISPLAY_TIME_ZONE,
  }).format(appointmentDate);
}

function normalizePhone(phone) {
  if (!phone) return "";
  let digits = String(phone).replace(/[^\d+]/g, "");
  if (digits.startsWith("+")) digits = digits.substring(1);
  if (digits.startsWith("00")) digits = digits.substring(2);
  return digits;
}

function asDate(value) {
  if (!value) return new Date();
  if (value.toDate) return value.toDate();
  return new Date(value);
}

function toTrimmedString(value) {
  if (typeof value !== "string") return "";
  return value.trim();
}

