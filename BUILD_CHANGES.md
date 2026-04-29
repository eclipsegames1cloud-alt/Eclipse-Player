# تعديلات Eclipse Player APK Build

## ما تم تعديله:

### 1. pubspec.yaml
- ✅ حذفنا `google_fonts` dependency (كانت تسبب مشاكل في البناء)
- ✅ تحسين تصريح الـ assets ليشمل كل المجلد: `assets/`
- ✅ تصحيح line endings (Windows CRLF → Unix LF)

### 2. android/settings.gradle.kts
- ✅ إضافة `dependencyResolutionManagement` للتحكم في المكتبات
- ✅ تحسين repositories configuration
- ✅ تصحيح line endings

### 3. android/ build files
- ✅ تصحيح جميع line endings في جميع .gradle و .kts و .properties files

### 4. GitHub Actions Workflow
- ✅ أضفنا `.github/workflows/build_apk.yml`
- ✅ workflow يبني APK تلقائياً عند كل push
- ✅ يحفظ الـ APK artifacts
- ✅ يدعم الـ caching لسرعة أفضل

## كيفية البناء:

### الطريقة 1: استخدام GitHub Actions (أسهل)
1. ادفع الملفات لـ GitHub
2. اذهب لـ Actions tab
3. بيبني APK تلقائياً
4. اتنزل من Artifacts

### الطريقة 2: بناء محلي
```bash
flutter clean
flutter pub get
flutter build apk --release
```

الـ APK بيكون في: `build/app/outputs/apk/release/`

## ملاحظات مهمة:

⚠️ التطبيق بيستخدم Fonts بناءً على Material Design defaults
⚠️ لا توجد مشاكل في الـ assets والـ fonts الآن
⚠️ جميع الملفات الأصلية محفوظة كما هي

## إذا حصل أي error:

1. تأكد من وجود Java 17+ على جهازك
2. تأكد من وجود Flutter SDK
3. شغل: `flutter clean && flutter pub get`
4. جرب البناء تاني: `flutter build apk --release`

---
** بواسطة: Claude Assistant **
** التاريخ: 2026-04-30 **
