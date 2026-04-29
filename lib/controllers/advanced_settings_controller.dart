import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/extended_models.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// ADVANCED SETTINGS CONTROLLER (PRODUCTION-READY)
/// Manages all app settings: Audio, Video, Downloads, Notifications, UI, etc.
/// ═══════════════════════════════════════════════════════════════════════════

class AdvancedSettingsController extends GetxController {
  late SharedPreferences _prefs;
  final isLoading = false.obs;

  // ═══════════════════════════════════════════════════════════════════════════
  // 🎵 AUDIO SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════
  
  final enableBackgroundPlayback = true.obs;
  final audioQuality = 'high'.obs; // low, medium, high, lossless
  final enableEqualizer = false.obs;
  final equalizerPreset = 'normal'.obs; // normal, rock, pop, jazz, classical
  final defaultPlaybackSpeed = 1.0.obs;
  final autoResumeLastAudio = true.obs;

  // ═══════════════════════════════════════════════════════════════════════════
  // 🎬 VIDEO SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════
  
  final defaultVideoQuality = 'auto'.obs; // auto, 720p, 1080p, 2k, 4k
  final enableGestures = true.obs;
  final enableSubtitles = true.obs;
  final autoFullscreen = false.obs;
  final defaultVideoSpeed = 1.0.obs;

  // ═══════════════════════════════════════════════════════════════════════════
  // ⬇️ DOWNLOAD SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════
  
  final wifiOnlyDownloads = false.obs;
  final downloadFolderPath = ''.obs;
  final maxParallelDownloads = 3.obs;
  final autoRetryFailed = true.obs;
  final retryAttempts = 3.obs;
  final deleteIncompleteOnCancel = false.obs;

  // ═══════════════════════════════════════════════════════════════════════════
  // 🔔 NOTIFICATION SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════
  
  final enableMediaNotification = true.obs;
  final showAudioImageInNotification = true.obs;
  final enableLockScreenControls = true.obs;
  final notificationClickOpensPlayer = true.obs;

  // ═══════════════════════════════════════════════════════════════════════════
  // 🎨 APPEARANCE SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════
  
  final themeMode = 'dark'.obs; // light, dark, amoled, system
  final accentColor = 'blue'.obs; // blue, purple, green, orange, red, pink
  final cardStyle = 'rounded'.obs; // rounded, sharp, minimal
  final fontScale = 1.0.obs; // 0.8 - 1.2
  final useAnimations = true.obs;

  // ═══════════════════════════════════════════════════════════════════════════
  // 🧠 SMART FEATURES
  // ═══════════════════════════════════════════════════════════════════════════
  
  final resumeLastMedia = true.obs;
  final trackRecentlyPlayed = true.obs;
  final autoOrganizeLibrary = false.obs;
  final enableSearchHistory = true.obs;
  final maxSearchHistory = 20.obs;

  @override
  void onInit() async {
    super.onInit();
    await _loadAllSettings();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LOAD & SAVE SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Load all settings from SharedPreferences
  Future<void> _loadAllSettings() async {
    try {
      isLoading.value = true;
      _prefs = await SharedPreferences.getInstance();

      // Load Audio Settings
      enableBackgroundPlayback.value =
          _prefs.getBool('enableBackgroundPlayback') ?? true;
      audioQuality.value = _prefs.getString('audioQuality') ?? 'high';
      enableEqualizer.value = _prefs.getBool('enableEqualizer') ?? false;
      equalizerPreset.value = _prefs.getString('equalizerPreset') ?? 'normal';
      defaultPlaybackSpeed.value =
          _prefs.getDouble('defaultPlaybackSpeed') ?? 1.0;
      autoResumeLastAudio.value =
          _prefs.getBool('autoResumeLastAudio') ?? true;

      // Load Video Settings
      defaultVideoQuality.value =
          _prefs.getString('defaultVideoQuality') ?? 'auto';
      enableGestures.value = _prefs.getBool('enableGestures') ?? true;
      enableSubtitles.value = _prefs.getBool('enableSubtitles') ?? true;
      autoFullscreen.value = _prefs.getBool('autoFullscreen') ?? false;
      defaultVideoSpeed.value =
          _prefs.getDouble('defaultVideoSpeed') ?? 1.0;

      // Load Download Settings
      wifiOnlyDownloads.value = _prefs.getBool('wifiOnlyDownloads') ?? false;
      downloadFolderPath.value =
          _prefs.getString('downloadFolderPath') ?? '';
      maxParallelDownloads.value =
          _prefs.getInt('maxParallelDownloads') ?? 3;
      autoRetryFailed.value = _prefs.getBool('autoRetryFailed') ?? true;
      retryAttempts.value = _prefs.getInt('retryAttempts') ?? 3;
      deleteIncompleteOnCancel.value =
          _prefs.getBool('deleteIncompleteOnCancel') ?? false;

      // Load Notification Settings
      enableMediaNotification.value =
          _prefs.getBool('enableMediaNotification') ?? true;
      showAudioImageInNotification.value =
          _prefs.getBool('showAudioImageInNotification') ?? true;
      enableLockScreenControls.value =
          _prefs.getBool('enableLockScreenControls') ?? true;
      notificationClickOpensPlayer.value =
          _prefs.getBool('notificationClickOpensPlayer') ?? true;

      // Load Appearance Settings
      themeMode.value = _prefs.getString('themeMode') ?? 'dark';
      accentColor.value = _prefs.getString('accentColor') ?? 'blue';
      cardStyle.value = _prefs.getString('cardStyle') ?? 'rounded';
      fontScale.value = _prefs.getDouble('fontScale') ?? 1.0;
      useAnimations.value = _prefs.getBool('useAnimations') ?? true;

      // Load Smart Features
      resumeLastMedia.value = _prefs.getBool('resumeLastMedia') ?? true;
      trackRecentlyPlayed.value =
          _prefs.getBool('trackRecentlyPlayed') ?? true;
      autoOrganizeLibrary.value =
          _prefs.getBool('autoOrganizeLibrary') ?? false;
      enableSearchHistory.value =
          _prefs.getBool('enableSearchHistory') ?? true;
      maxSearchHistory.value = _prefs.getInt('maxSearchHistory') ?? 20;

      isLoading.value = false;
      print('✓ All settings loaded successfully');
    } catch (e) {
      print('✗ Error loading settings: $e');
      isLoading.value = false;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 🎵 AUDIO SETTINGS METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> setBackgroundPlayback(bool value) async {
    enableBackgroundPlayback.value = value;
    await _prefs.setBool('enableBackgroundPlayback', value);
  }

  Future<void> setAudioQuality(String quality) async {
    audioQuality.value = quality;
    await _prefs.setString('audioQuality', quality);
  }

  Future<void> setEqualizerEnabled(bool value) async {
    enableEqualizer.value = value;
    await _prefs.setBool('enableEqualizer', value);
  }

  Future<void> setEqualizerPreset(String preset) async {
    equalizerPreset.value = preset;
    await _prefs.setString('equalizerPreset', preset);
  }

  Future<void> setDefaultPlaybackSpeed(double speed) async {
    defaultPlaybackSpeed.value = speed;
    await _prefs.setDouble('defaultPlaybackSpeed', speed);
  }

  Future<void> setAutoResumeAudio(bool value) async {
    autoResumeLastAudio.value = value;
    await _prefs.setBool('autoResumeLastAudio', value);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 🎬 VIDEO SETTINGS METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> setVideoQuality(String quality) async {
    defaultVideoQuality.value = quality;
    await _prefs.setString('defaultVideoQuality', quality);
  }

  Future<void> setGesturesEnabled(bool value) async {
    enableGestures.value = value;
    await _prefs.setBool('enableGestures', value);
  }

  Future<void> setSubtitlesEnabled(bool value) async {
    enableSubtitles.value = value;
    await _prefs.setBool('enableSubtitles', value);
  }

  Future<void> setAutoFullscreen(bool value) async {
    autoFullscreen.value = value;
    await _prefs.setBool('autoFullscreen', value);
  }

  Future<void> setDefaultVideoSpeed(double speed) async {
    defaultVideoSpeed.value = speed;
    await _prefs.setDouble('defaultVideoSpeed', speed);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ⬇️ DOWNLOAD SETTINGS METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> setWifiOnlyDownloads(bool value) async {
    wifiOnlyDownloads.value = value;
    await _prefs.setBool('wifiOnlyDownloads', value);
  }

  Future<void> setDownloadFolder(String path) async {
    downloadFolderPath.value = path;
    await _prefs.setString('downloadFolderPath', path);
  }

  Future<void> setMaxParallelDownloads(int count) async {
    final validCount = count.clamp(1, 10);
    maxParallelDownloads.value = validCount;
    await _prefs.setInt('maxParallelDownloads', validCount);
  }

  Future<void> setAutoRetryFailed(bool value) async {
    autoRetryFailed.value = value;
    await _prefs.setBool('autoRetryFailed', value);
  }

  Future<void> setRetryAttempts(int count) async {
    final validCount = count.clamp(1, 10);
    retryAttempts.value = validCount;
    await _prefs.setInt('retryAttempts', validCount);
  }

  Future<void> setDeleteIncompleteOnCancel(bool value) async {
    deleteIncompleteOnCancel.value = value;
    await _prefs.setBool('deleteIncompleteOnCancel', value);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 🔔 NOTIFICATION SETTINGS METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> setMediaNotification(bool value) async {
    enableMediaNotification.value = value;
    await _prefs.setBool('enableMediaNotification', value);
  }

  Future<void> setShowAudioImageInNotification(bool value) async {
    showAudioImageInNotification.value = value;
    await _prefs.setBool('showAudioImageInNotification', value);
  }

  Future<void> setLockScreenControls(bool value) async {
    enableLockScreenControls.value = value;
    await _prefs.setBool('enableLockScreenControls', value);
  }

  Future<void> setNotificationClickOpensPlayer(bool value) async {
    notificationClickOpensPlayer.value = value;
    await _prefs.setBool('notificationClickOpensPlayer', value);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 🎨 APPEARANCE SETTINGS METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> setThemeMode(String mode) async {
    themeMode.value = mode;
    await _prefs.setString('themeMode', mode);
  }

  Future<void> setAccentColor(String color) async {
    accentColor.value = color;
    await _prefs.setString('accentColor', color);
  }

  Future<void> setCardStyle(String style) async {
    cardStyle.value = style;
    await _prefs.setString('cardStyle', style);
  }

  Future<void> setFontScale(double scale) async {
    final validScale = scale.clamp(0.8, 1.2);
    fontScale.value = validScale;
    await _prefs.setDouble('fontScale', validScale);
  }

  Future<void> setUseAnimations(bool value) async {
    useAnimations.value = value;
    await _prefs.setBool('useAnimations', value);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 🧠 SMART FEATURES METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> setResumeLastMedia(bool value) async {
    resumeLastMedia.value = value;
    await _prefs.setBool('resumeLastMedia', value);
  }

  Future<void> setTrackRecentlyPlayed(bool value) async {
    trackRecentlyPlayed.value = value;
    await _prefs.setBool('trackRecentlyPlayed', value);
  }

  Future<void> setAutoOrganizeLibrary(bool value) async {
    autoOrganizeLibrary.value = value;
    await _prefs.setBool('autoOrganizeLibrary', value);
  }

  Future<void> setSearchHistory(bool value) async {
    enableSearchHistory.value = value;
    await _prefs.setBool('enableSearchHistory', value);
  }

  Future<void> setMaxSearchHistory(int max) async {
    final validMax = max.clamp(5, 100);
    maxSearchHistory.value = validMax;
    await _prefs.setInt('maxSearchHistory', validMax);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Reset all settings to defaults
  Future<void> resetToDefaults() async {
    try {
      await _prefs.clear();
      await _loadAllSettings();
      Get.snackbar(
        'تم إعادة التعيين',
        'تم إعادة جميع الإعدادات إلى القيم الافتراضية',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل إعادة التعيين: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Export all settings as JSON
  Map<String, dynamic> exportSettings() {
    return {
      'audio': {
        'enableBackgroundPlayback': enableBackgroundPlayback.value,
        'audioQuality': audioQuality.value,
        'enableEqualizer': enableEqualizer.value,
        'equalizerPreset': equalizerPreset.value,
        'defaultPlaybackSpeed': defaultPlaybackSpeed.value,
        'autoResumeLastAudio': autoResumeLastAudio.value,
      },
      'video': {
        'defaultVideoQuality': defaultVideoQuality.value,
        'enableGestures': enableGestures.value,
        'enableSubtitles': enableSubtitles.value,
        'autoFullscreen': autoFullscreen.value,
        'defaultVideoSpeed': defaultVideoSpeed.value,
      },
      'downloads': {
        'wifiOnlyDownloads': wifiOnlyDownloads.value,
        'maxParallelDownloads': maxParallelDownloads.value,
        'autoRetryFailed': autoRetryFailed.value,
        'retryAttempts': retryAttempts.value,
      },
      'notifications': {
        'enableMediaNotification': enableMediaNotification.value,
        'showAudioImageInNotification': showAudioImageInNotification.value,
        'enableLockScreenControls': enableLockScreenControls.value,
      },
      'appearance': {
        'themeMode': themeMode.value,
        'accentColor': accentColor.value,
        'cardStyle': cardStyle.value,
        'fontScale': fontScale.value,
      },
      'smartFeatures': {
        'resumeLastMedia': resumeLastMedia.value,
        'trackRecentlyPlayed': trackRecentlyPlayed.value,
        'autoOrganizeLibrary': autoOrganizeLibrary.value,
      },
    };
  }
}
