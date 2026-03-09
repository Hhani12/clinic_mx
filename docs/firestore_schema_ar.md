# Firestore Schema (Clinic MX)

## 1) users/{uid}
```json
{
  "uid": "string",
  "clinicId": "string",
  "email": "string",
  "displayName": "string",
  "role": "admin|doctor|reception",
  "isActive": true,
  "fcmToken": "string?"
}
```

## 2) clinics/{clinicId}
```json
{
  "id": "string",
  "name": "string",
  "phone": "string?",
  "city": "string?",
  "district": "string?",
  "address": "string?",
  "updatedAt": "timestamp"
}
```

## 3) clinics/{clinicId}/settings/config
```json
{
  "reminderOffsetHours": 24,
  "teethNumberingSystem": "fdi|universal",
  "toothActions": ["قلع", "حشو", "تنظيف", "تقويم", "عصب"],
  "whatsAppEnabled": true,
  "smsEnabled": false,
  "emailEnabled": false,
  "phoneAuthEnabled": false
}
```

## 4) clinics/{clinicId}/patients/{patientId}
```json
{
  "id": "string",
  "clinicId": "string",
  "firstName": "string",
  "fatherName": "string",
  "lastName": "string",
  "displayName": "string",
  "displayNameLower": "string",
  "phoneNumber": "+9647XXXXXXXX",
  "city": "string?",
  "district": "string?",
  "detailedAddress": "string?",
  "dob": "timestamp?",
  "gender": "male|female?",
  "nationalId": "string?",
  "reasonForVisit": "string?",
  "medicalNotes": "string?",
  "allergies": ["string"],
  "chronicDiseases": ["string"],
  "attachmentUrls": ["string"],
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

## 5) clinics/{clinicId}/appointments/{appointmentId}
```json
{
  "id": "string",
  "clinicId": "string",
  "patientId": "string",
  "patientName": "string",
  "patientPhone": "string",
  "startAt": "timestamp",
  "durationMinutes": 30,
  "reason": "string",
  "status": "scheduled|checked_in|in_treatment|completed|no_show|cancelled",
  "doctorId": "string",
  "reminderSent": false,
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

## 6) clinics/{clinicId}/payments/{paymentId}
```json
{
  "id": "string",
  "clinicId": "string",
  "patientId": "string",
  "patientName": "string",
  "appointmentId": "string?",
  "amount": 100.0,
  "paid": 40.0,
  "remaining": 60.0,
  "method": "cash|card|transfer",
  "date": "timestamp",
  "notes": "string?",
  "createdBy": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

## 7) clinics/{clinicId}/dentalPlans/{itemId}
```json
{
  "id": "string",
  "clinicId": "string",
  "patientId": "string",
  "toothId": "string",
  "numberingSystem": "fdi|universal",
  "actionLabel": "string",
  "note": "string",
  "timestamp": "timestamp",
  "doctorId": "string"
}
```

## 8) clinics/{clinicId}/reminderLogs/{logId}
```json
{
  "id": "string",
  "clinicId": "string",
  "appointmentId": "string",
  "patientId": "string",
  "channel": "whatsapp|sms|email|none",
  "status": "sent|failed",
  "providerResponse": "string",
  "scheduledFor": "timestamp",
  "executedAt": "timestamp",
  "createdAt": "timestamp"
}
```
