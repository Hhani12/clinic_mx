# WhatsApp Appointment Reminder Setup Guide — Locas Clinic

This guide walks you through connecting the **Meta WhatsApp Business API** to your Locas Clinic app so that patients automatically receive a WhatsApp message **24 hours before** their scheduled appointment.

---

## How It Works (Architecture)

```
                      every 1 minute
Firebase Cloud Function ───────────────> Queries Firestore
  (processAppointmentReminders)            |
                                           | Finds appointments where
                                           | startAt is ~24 hours from now
                                           | AND status == "scheduled"
                                           | AND reminderSent != true
                                           v
                                    Meta WhatsApp API
                                    (graph.facebook.com)
                                           |
                                           v
                                    Patient receives
                                    WhatsApp message
```

**Key files in your project:**

| File | Purpose |
|------|---------|
| `functions/index.js` | Cloud Function that runs every 1 minute, finds appointments due for reminders, sends WhatsApp messages |
| `lib/core/services/whatsapp/whatsapp_service.dart` | Flutter-side WhatsApp service (for manual sends from the app) |
| `lib/core/services/whatsapp/whatsapp_providers.dart` | Riverpod provider for the WhatsApp service |
| `lib/features/settings/domain/entities/clinic_settings.dart` | Stores `whatsAppEnabled`, `whatsAppPhoneNumberId`, `whatsAppSenderNumber` |
| `lib/features/settings/presentation/pages/settings_page.dart` | UI for configuring WhatsApp settings |

---

## Step 1: Create a Meta Business Account

1. Go to **https://business.facebook.com/** and create a Business Account (or use an existing one)
2. Go to **https://developers.facebook.com/** and log in with the same account
3. Click **My Apps** > **Create App**
4. Select **Business** type > **Next**
5. Give your app a name (e.g., "Locas Clinic Reminders") > **Create App**

---

## Step 2: Add WhatsApp to Your Meta App

1. In the Meta Developer Dashboard, find your new app
2. Scroll to **Add Products** > find **WhatsApp** > click **Set Up**
3. You'll see the **WhatsApp Getting Started** page with:
   - A **temporary Phone Number ID** (test number)
   - A **temporary Access Token** (expires in 24 hours)

**Write these down** — you'll need them for testing.

---

## Step 3: Get a Permanent Access Token

The temporary token expires in 24 hours. For production you need a **System User token**:

1. Go to **https://business.facebook.com/settings/system-users**
2. Click **Add** > name it "Clinic Reminder Bot" > role: **Admin**
3. Click the new system user > **Generate New Token**
4. Select your WhatsApp app
5. Check these permissions:
   - `whatsapp_business_messaging`
   - `whatsapp_business_management`
6. Click **Generate Token**
7. **Copy the token immediately** — it won't be shown again

This token **never expires** (unless you revoke it).

---

## Step 4: Register Your Real Phone Number (Production)

For testing, Meta provides a sandbox number. For production:

1. In the Meta Developer Dashboard > **WhatsApp** > **Getting Started**
2. Click **Add phone number**
3. Enter the phone number you want to send FROM (your clinic's WhatsApp Business number)
4. Verify via SMS or voice call
5. After verification, note your new **Phone Number ID** (different from the test one)

> **Important**: The FROM number must be a phone number that is NOT already registered on regular WhatsApp. You'll need a dedicated number for the business API. You can migrate an existing WhatsApp Business App number to the API.

---

## Step 5: Create the Message Template

WhatsApp requires **pre-approved templates** for business-initiated messages. You cannot send free-form text — only templates.

1. Go to Meta Developer Dashboard > **WhatsApp** > **Message Templates**
2. Click **Create Template**
3. Configure:
   - **Category**: `UTILITY`
   - **Name**: `appointment_reminder`
   - **Language**: `Arabic (ar)`
4. Template body text:

```
السلام عليكم {{1}} حضرتك عندك موعد زيارة
في {{2}} في {{3}} اخبرنا اذا لديك اي استفسار
```

Where:
- `{{1}}` = Patient name
- `{{2}}` = Appointment date/time
- `{{3}}` = Reminder message text (includes clinic name and reason)

5. Submit for review — Meta usually approves utility templates within minutes to a few hours.

> **Note**: The template name `appointment_reminder` must match exactly what's in `functions/index.js` and what you set in the Firebase secret `WHATSAPP_TEMPLATE_NAME`. You can customize the name but keep it consistent.

---

## Step 6: Set Firebase Secrets

The Cloud Function reads credentials from Firebase Secrets (not hardcoded). Run these commands in your terminal from the project root:

```bash
# Required for WhatsApp
firebase functions:secrets:set WHATSAPP_TOKEN
# Paste your permanent System User access token when prompted

firebase functions:secrets:set WHATSAPP_PHONE_NUMBER_ID
# Paste your Phone Number ID (from Meta Dashboard > WhatsApp > Getting Started)

firebase functions:secrets:set WHATSAPP_TEMPLATE_NAME
# Type: appointment_reminder (or your custom template name)
```

**Optional** (for SMS/email fallback):

```bash
# Twilio (SMS fallback)
firebase functions:secrets:set TWILIO_ACCOUNT_SID
firebase functions:secrets:set TWILIO_AUTH_TOKEN
firebase functions:secrets:set TWILIO_FROM

# SendGrid (email fallback)
firebase functions:secrets:set SENDGRID_API_KEY
firebase functions:secrets:set SENDGRID_FROM_EMAIL
```

Verify secrets are set:

```bash
firebase functions:secrets:access WHATSAPP_TOKEN
firebase functions:secrets:access WHATSAPP_PHONE_NUMBER_ID
```

---

## Step 7: Deploy the Cloud Function

```bash
cd functions
npm install
cd ..
firebase deploy --only functions
```

After deployment, verify it's running:

```bash
firebase functions:log --only processAppointmentReminders
```

You should see logs like:
```
Processing reminders for 1 clinics.
Clinic abc123: found 0 appointments for reminder window.
```

---

## Step 8: Configure WhatsApp in the App UI

1. Open your Locas Clinic app (web or desktop)
2. Go to **Settings** (gear icon)
3. In the **Reminder Settings** section:
   - **WhatsApp toggle**: Turn ON
   - **WhatsApp Sender Number**: Enter your sender phone number (with country code, e.g., `964XXXXXXXXX`)
   - **WhatsApp Phone Number ID**: Enter the Phone Number ID from the Meta Dashboard
4. Save settings

These values are stored in Firestore at `clinics/{clinicId}/settings/config` and read by the Cloud Function.

---

## Step 9: Test It

### Quick Test (Sandbox)

1. In the Meta Developer Dashboard > **WhatsApp** > **Getting Started**
2. Under **Send and receive messages**, add your personal phone number as a test recipient
3. In the Locas Clinic app, create an appointment scheduled for **exactly 24 hours from now**
4. Wait 1-2 minutes (the Cloud Function runs every minute)
5. Check:
   - Firebase Functions logs: `firebase functions:log`
   - Firestore: Look at `clinics/{clinicId}/reminderLogs/` for the log entry
   - Your phone: You should receive the WhatsApp message

### Production Test

1. Create a real appointment with a real patient phone number
2. The phone number must include the country code (e.g., `964` for Iraq)
3. Schedule it 24 hours from now
4. Monitor the logs

---

## Step 10: Verify the Reminder Flow

The Cloud Function (`functions/index.js`) does this every minute:

1. Gets all clinics
2. For each clinic, reads `settings/config` to check if WhatsApp is enabled
3. Queries appointments where:
   - `startAt` is between **now + 24 hours** and **now + 24 hours + 1 minute**
   - `status == "scheduled"`
   - `reminderSent != true`
4. For each matching appointment:
   - Looks up the patient's phone number
   - Sends the WhatsApp template message
   - Writes a log to `clinics/{clinicId}/reminderLogs/{appointmentId}_24`
   - Marks the appointment `reminderSent: true`

**Fallback chain**: WhatsApp -> SMS (Twilio) -> Email (SendGrid). If WhatsApp fails, it tries the next channel.

---

## Phone Number Format

The function normalizes phone numbers automatically, but for best results store them in Firestore with:
- Country code included (e.g., `964XXXXXXXXX` for Iraq, `966XXXXXXXXX` for Saudi Arabia)
- No leading `+` or `00` (the function strips these)
- Digits only, no spaces or dashes

---

## Troubleshooting

### "Missing WhatsApp token or phone number id"
- Run `firebase functions:secrets:access WHATSAPP_TOKEN` to verify the secret is set
- Make sure you deployed after setting secrets: `firebase deploy --only functions`

### Template not approved
- Check template status in Meta Developer Dashboard > WhatsApp > Message Templates
- Common rejection reasons: promotional content in UTILITY template, unclear variable usage
- Use the exact template format from Step 5

### Messages sent but not received
- Check the Firestore `reminderLogs` collection for status `"sent"` vs `"failed"`
- Look at `providerResponse` field in the log for Meta's error details
- Common issues:
  - Patient phone not registered on WhatsApp
  - Phone number format wrong (missing country code)
  - Template parameters don't match the approved template
  - Rate limits exceeded

### Function not triggering
- Verify the function is deployed: `firebase functions:list`
- Check logs: `firebase functions:log --only processAppointmentReminders`
- The Cloud Scheduler must be enabled in your Google Cloud project (usually automatic)

### "429 Too Many Requests"
- Meta has rate limits: 250 messages/second for new numbers, 1000/second for verified businesses
- For a single clinic this is never an issue

### Appointment not getting a reminder
- Check the appointment's `startAt` field is a Firestore Timestamp (not a string)
- Check `status` is exactly `"scheduled"` (not "Scheduled" or "confirmed")
- Check `reminderSent` is not already `true`
- The time window is tight: the function checks for appointments exactly 24 hours ahead, within a 1-minute window

---

## Cost

| Component | Cost |
|-----------|------|
| **Meta WhatsApp API** | First 1,000 utility conversations/month are FREE. After that, ~$0.02-0.05 per conversation depending on country |
| **Firebase Cloud Functions** | First 2M invocations/month free. The scheduler costs ~$0.10/month |
| **Firebase Secrets** | Free (uses Google Secret Manager, free tier covers this) |

For a typical clinic with 20-50 appointments/day, you'll stay well within free tiers.

---

## Summary Checklist

- [ ] Meta Business Account created
- [ ] Meta Developer App created with WhatsApp product
- [ ] System User created with permanent access token
- [ ] Real phone number registered and verified (for production)
- [ ] Message template `appointment_reminder` created and approved
- [ ] Firebase secrets set: `WHATSAPP_TOKEN`, `WHATSAPP_PHONE_NUMBER_ID`, `WHATSAPP_TEMPLATE_NAME`
- [ ] Cloud Function deployed: `firebase deploy --only functions`
- [ ] App settings: WhatsApp enabled, Phone Number ID entered
- [ ] Test appointment created 24 hours ahead, reminder received
