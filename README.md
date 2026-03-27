# Locas Clinic

تطبيق Flutter لإدارة العيادات (Arabic-first RTL) يعمل على:
- Windows Desktop
- Android
- iOS

الواجهة مبنية بأسلوب `Liquid Glass` (glassmorphism + gradients + blur) مع نظام Tokens قابل للتعديل السريع.

## المزايا
- مصادقة Firebase (Email/Password + تصميم جاهز للهاتف)
- RBAC أدوار: `admin / doctor / reception`
- إدارة المرضى (CRUD كامل) مع التحقق من الاسم العربي الثلاثي ورقم E.164
- المواعيد + زيارات اليوم + حالات الزيارة
- خريطة أسنان تفاعلية (FDI / Universal) مع إجراءات مخصصة
- المدفوعات والفواتير
- إعدادات العيادة والتذكير والثيم
- قواعد أمان Firestore/Storage + Cloud Functions للتذكيرات

## المعمارية
- `Riverpod + go_router`
- `Clean Architecture` + feature modules
- Arabic-first RTL + English support

## تشغيل المشروع
```bash
flutter pub get
flutter analyze
flutter test
```

### تشغيل Windows
```bash
flutter run -d windows
```

### بناء EXE (Release)
```bash
flutter build windows --release
```

### تشغيل Android
```bash
flutter devices
flutter run -d <android-device-id>
```

### بناء APK
```bash
flutter build apk --release
```

### تشغيل iOS
```bash
flutter devices
flutter run -d <ios-device-id>
```

### بناء iOS IPA
```bash
flutter build ipa --release
```

## Firebase Setup
الخطوات التفصيلية في:
- `docs/firebase_setup_ar.md`

ملفات النشر:
- `firestore.rules`
- `storage.rules`
- `firestore.indexes.json`
- `firebase.json`
- `functions/index.js`

## نشر القواعد والدوال
```bash
firebase login
firebase use <project-id>
firebase deploy --only firestore:rules,firestore:indexes,storage
firebase deploy --only functions
```

## ملاحظات
- تكامل WhatsApp يتم فقط عبر **WhatsApp Business Cloud API الرسمي** داخل Cloud Functions.
- مفاتيح WhatsApp/Twilio/SendGrid لا توضع داخل تطبيق Flutter؛ فقط في بيئة Functions.
- اختبار integration موجود في:
  `integration_test/login_create_patient_test.dart`
