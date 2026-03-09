# إعداد Firebase لـ Clinic MX

## 1) إنشاء مشروع Firebase
1. افتح Firebase Console.
2. أنشئ مشروع جديد (مثال: `clinic-mx-project`).
3. فعّل:
   - Authentication
   - Firestore
   - Storage
   - Cloud Messaging
   - Cloud Functions

## 2) Authentication
1. من Authentication > Sign-in method:
   - فعّل `Email/Password`.
   - فعّل `Phone` فقط إذا أردت استعماله لاحقاً.

## 3) ربط Flutter بالتطبيق
شغّل:
```bash
dart pub global activate flutterfire_cli
flutterfire configure --project=<PROJECT_ID>
```

ثم استبدل `lib/firebase_options.dart` بملف FlutterFire الناتج.

## 4) Android setup
1. أضف تطبيق Android في Firebase.
2. نزّل `google-services.json` وضعه في:
   - `android/app/google-services.json`
3. تأكد من إعدادات Gradle لـ Google Services.
4. FCM:
   - لا تحتاج كود إضافي للسيرفر هنا، التوكن يُحفظ تلقائياً في `users/{uid}.fcmToken`.

## 5) iOS setup
1. أضف تطبيق iOS في Firebase.
2. نزّل `GoogleService-Info.plist` وضعه في:
   - `ios/Runner/GoogleService-Info.plist`
3. فعّل Push Notifications و Background Modes في Xcode:
   - `Push Notifications`
   - `Background fetch`
   - `Remote notifications`
4. اربط APNs Key مع Firebase Cloud Messaging.

## 6) Windows setup
1. أضف تطبيق Windows في Firebase.
2. حدّث `firebase_options.dart` بقيم Windows الفعلية.
3. تأكد من توفر Firebase C++ SDK عند البناء (يتم غالباً تلقائياً أثناء build).

## 7) Firestore & Storage Rules
من جذر المشروع:
```bash
firebase deploy --only firestore:rules,firestore:indexes,storage
```

الملفات المستخدمة:
- `firestore.rules`
- `firestore.indexes.json`
- `storage.rules`

## 8) Cloud Functions (التذكيرات)
1. ثبّت Dependencies:
```bash
cd functions
npm install
cd ..
```
2. اضبط أسرار المزودات في Functions Environment:
```bash
firebase functions:secrets:set WHATSAPP_TOKEN
firebase functions:secrets:set WHATSAPP_PHONE_NUMBER_ID
firebase functions:secrets:set WHATSAPP_TEMPLATE_NAME
firebase functions:secrets:set TWILIO_ACCOUNT_SID
firebase functions:secrets:set TWILIO_AUTH_TOKEN
firebase functions:secrets:set TWILIO_FROM
firebase functions:secrets:set SENDGRID_API_KEY
firebase functions:secrets:set SENDGRID_FROM_EMAIL
```
3. انشر الدوال:
```bash
firebase deploy --only functions
```

## 9) بنية البيانات (Collections)
- `users/{uid}`
- `clinics/{clinicId}`
- `clinics/{clinicId}/patients/{patientId}`
- `clinics/{clinicId}/appointments/{appointmentId}`
- `clinics/{clinicId}/payments/{paymentId}`
- `clinics/{clinicId}/dentalPlans/{itemId}`
- `clinics/{clinicId}/reminderLogs/{logId}`
- `clinics/{clinicId}/settings/config`

## 10) ملاحظات أمنية
- لا تضع مفاتيح WhatsApp/Twilio/SendGrid داخل Flutter client.
- أي إرسال رسائل يجب أن يتم من Cloud Functions فقط.
- تأكد أن كل المستندات تحتوي `clinicId` مطابق لمسار العيادة.
