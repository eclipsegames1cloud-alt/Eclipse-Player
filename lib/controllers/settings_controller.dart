import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/extended_models.dart';
import '../utils/constants.dart';

/// ✨ IMPROVED: Enhanced settings controller with user preferences caching
/// تحسين: إضافة حفظ وتحميل التفضيلات من shared_preferences
class SettingsController extends GetxController {
  late SharedPreferences _prefs;
  
  // ✨ IMPROVED: User preferences as observables for real-time UI updates
  final videoQuality = 'auto'.obs;
  final audioQuality = 'high'.obs;
  final isDarkMode = true.obs;
  final isNightMode = false.obs;
  final autoPlayEnabled = false.obs;
  final downloadWifiOnly = false.obs;
  final parallelDownloads = 3.obs;
  final showNotifications = true.obs;
  final resumeLastPlayback = true.obs;
  final language = 'ar_EG'.obs; // تحسين: دعم اللغات
  final fontSize = 'medium'.obs;
  final accentColor = 'primary'.obs;
  
  // ✨ IMPROVED: Video control preferences
  final gestureSeekEnabled = true.obs;
  final brightnessControlEnabled = true.obs;
  final volumeControlEnabled = true.obs;
  final gestureSeekSensitivity = 1.0.obs; // تحسين: حساسية الحركات
  
  // ✨ IMPROVED: Loading state for async operations
  final isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    // تحسين: تحميل التفضيلات بشكل غير متزامن
    await _loadPreferences();
  }

  /// ✨ IMPROVED: Load user preferences from local storage
  /// تحسين: تحميل سريع من الـ cache مع معالجة الأخطاء
  Future<void> _loadPreferences() async {
    try {
      isLoading.value = true;
      _prefs = await SharedPreferences.getInstance();
      
      // تحسين: تحميل كل التفضيلات مرة واحدة
      videoQuality.value = _prefs.getString('videoQuality') ?? 'auto';
      audioQuality.value = _prefs.getString('audioQuality') ?? 'high';
      isDarkMode.value = _prefs.getBool('isDarkMode') ?? true;
      isNightMode.value = _prefs.getBool('isNightMode') ?? false;
      autoPlayEnabled.value = _prefs.getBool('autoPlayEnabled') ?? false;
      downloadWifiOnly.value = _prefs.getBool('downloadWifiOnly') ?? false;
      parallelDownloads.value = _prefs.getInt('parallelDownloads') ?? 3;
      showNotifications.value = _prefs.getBool('showNotifications') ?? true;
      resumeLastPlayback.value = _prefs.getBool('resumeLastPlayback') ?? true;
      language.value = _prefs.getString('language') ?? 'ar_EG';
      fontSize.value = _prefs.getString('fontSize') ?? 'medium';
      accentColor.value = _prefs.getString('accentColor') ?? 'primary';
      
      // Video control preferences
      gestureSeekEnabled.value = _prefs.getBool('gestureSeekEnabled') ?? true;
      brightnessControlEnabled.value = _prefs.getBool('brightnessControlEnabled') ?? true;
      volumeControlEnabled.value = _prefs.getBool('volumeControlEnabled') ?? true;
      gestureSeekSensitivity.value = _prefs.getDouble('gestureSeekSensitivity') ?? 1.0;
      
      print('${LogTags.settings} تم تحميل التفضيلات بنجاح');
      isLoading.value = false;
    } catch (e) {
      print('${LogTags.settings} خطأ في تحميل التفضيلات: $e');
      isLoading.value = false;
    }
  }

  /// ✨ IMPROVED: Save video quality preference
  /// تحسين: حفظ سريع مع تحديث فوري
  Future<void> setVideoQuality(String quality) async {
    videoQuality.value = quality;
    await _prefs.setString('videoQuality', quality);
    print('${LogTags.settings} تم حفظ جودة الفيديو: $quality');
  }

  /// ✨ IMPROVED: Save audio quality preference
  Future<void> setAudioQuality(String quality) async {
    audioQuality.value = quality;
    await _prefs.setString('audioQuality', quality);
    print('${LogTags.settings} تم حفظ جودة الصوت: $quality');
  }

  /// ✨ IMPROVED: Toggle dark mode with persistence
  /// تحسين: تبديل الوضع الليلي مع الحفظ
  Future<void> toggleDarkMode(bool value) async {
    isDarkMode.value = value;
    await _prefs.setBool('isDarkMode', value);
    print('${LogTags.settings} تم تبديل الوضع الليلي: $value');
  }

  /// ✨ IMPROVED: Toggle night mode (blue light filter)
  /// تحسين: وضع ليلي خاص (يقلل الضوء الأزرق)
  Future<void> toggleNightMode(bool value) async {
    isNightMode.value = value;
    await _prefs.setBool('isNightMode', value);
    print('${LogTags.settings} تم تبديل وضع الليل: $value');
  }

  /// ✨ IMPROVED: Set autoplay preference
  Future<void> setAutoPlay(bool value) async {
    autoPlayEnabled.value = value;
    await _prefs.setBool('autoPlayEnabled', value);
  }

  /// ✨ IMPROVED: Set WiFi only download mode
  Future<void> setDownloadWifiOnly(bool value) async {
    downloadWifiOnly.value = value;
    await _prefs.setBool('downloadWifiOnly', value);
  }

  /// ✨ IMPROVED: Set parallel downloads count with validation
  /// تحسين: التحقق من الحد الأقصى والأدنى
  Future<void> setParallelDownloads(int count) async {
    final validCount = count.clamp(1, 10); // تحسين: الحد 1-10
    parallelDownloads.value = validCount;
    await _prefs.setInt('parallelDownloads', validCount);
  }

  /// ✨ IMPROVED: Toggle notifications
  Future<void> setNotifications(bool value) async {
    showNotifications.value = value;
    await _prefs.setBool('showNotifications', value);
  }

  /// ✨ IMPROVED: Set resume playback preference
  Future<void> setResumePlayback(bool value) async {
    resumeLastPlayback.value = value;
    await _prefs.setBool('resumeLastPlayback', value);
  }

  /// ✨ IMPROVED: Change language (for future localization)
  /// تحسين: دعم تغيير اللغة
  Future<void> setLanguage(String lang) async {
    language.value = lang;
    await _prefs.setString('language', lang);
    // TODO: تطبيق تغيير اللغة الفعلي
  }

  /// ✨ IMPROVED: Set font size preference
  /// تحسين: تحكم بحجم الخط
  Future<void> setFontSize(String size) async {
    fontSize.value = size;
    await _prefs.setString('fontSize', size);
  }

  /// ✨ IMPROVED: Set accent color
  /// تحسين: تخصيص الألوان
  Future<void> setAccentColor(String color) async {
    accentColor.value = color;
    await _prefs.setString('accentColor', color);
  }

  /// ✨ IMPROVED: Video gesture controls settings
  /// تحسين: إعدادات التحكم بالحركات
  Future<void> setGestureSeekEnabled(bool value) async {
    gestureSeekEnabled.value = value;
    await _prefs.setBool('gestureSeekEnabled', value);
  }

  Future<void> setBrightnessControlEnabled(bool value) async {
    brightnessControlEnabled.value = value;
    await _prefs.setBool('brightnessControlEnabled', value);
  }

  Future<void> setVolumeControlEnabled(bool value) async {
    volumeControlEnabled.value = value;
    await _prefs.setBool('volumeControlEnabled', value);
  }

  /// ✨ IMPROVED: Set gesture sensitivity (0.5x to 2.0x)
  /// تحسين: حساسية قابلة للتخصيص
  Future<void> setGestureSeekSensitivity(double sensitivity) async {
    final validSensitivity = sensitivity.clamp(0.5, 2.0);
    gestureSeekSensitivity.value = validSensitivity;
    await _prefs.setDouble('gestureSeekSensitivity', validSensitivity);
  }

  /// ✨ IMPROVED: Reset all settings to defaults
  /// تحسين: إعادة تعيين كل الإعدادات
  Future<void> resetToDefaults() async {
    try {
      await _prefs.clear();
      await _loadPreferences();
      print('${LogTags.settings} تم إعادة تعيين جميع الإعدادات');
    } catch (e) {
      print('${LogTags.settings} خطأ في إعادة التعيين: $e');
    }
  }

  /// ✨ IMPROVED: Export settings as JSON for backup
  /// تحسين: تصدير الإعدادات للنسخ الاحتياطي
  Map<String, dynamic> exportSettings() {
    return {
      'videoQuality': videoQuality.value,
      'audioQuality': audioQuality.value,
      'isDarkMode': isDarkMode.value,
      'isNightMode': isNightMode.value,
      'autoPlayEnabled': autoPlayEnabled.value,
      'downloadWifiOnly': downloadWifiOnly.value,
      'parallelDownloads': parallelDownloads.value,
      'showNotifications': showNotifications.value,
      'resumeLastPlayback': resumeLastPlayback.value,
      'language': language.value,
      'fontSize': fontSize.value,
      'accentColor': accentColor.value,
      'gestureSeekEnabled': gestureSeekEnabled.value,
      'brightnessControlEnabled': brightnessControlEnabled.value,
      'volumeControlEnabled': volumeControlEnabled.value,
      'gestureSeekSensitivity': gestureSeekSensitivity.value,
    };
  }
}
