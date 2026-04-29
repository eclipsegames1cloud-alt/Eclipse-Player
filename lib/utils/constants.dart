/// App-wide constants and configuration
class AppConstants {
  // App Identification
  static const String appName = 'Eclipse Player';
  static const String appVersion = '1.0.0';
  static const String appBuild = '1';
  static const String appAuthor = 'ƎMINEM';
  
  // URLs and API
  static const String youtubeBaseUrl = 'https://www.youtube.com';
  static const String defaultThumbnailUrl = 'https://via.placeholder.com/300x200?text=No+Image';
  
  // File Paths and Storage
  static const String downloadsFolderName = 'EclipsePlayer/Downloads';
  static const String audioFolderName = 'EclipsePlayer/Audio';
  static const String videoFolderName = 'EclipsePlayer/Videos';
  static const String thumbnailFolderName = 'EclipsePlayer/Thumbnails';
  
  // Database
  static const String databaseName = 'eclipse_player.db';
  static const int databaseVersion = 2;
  
  // SharedPreferences Keys
  static const String prefLastPlayedMedia = 'last_played_media';
  static const String prefLastPlaybackPosition = 'last_playback_position';
  static const String prefAppSettings = 'app_settings';
  static const String prefUserTheme = 'user_theme';
  static const String prefAudioVolume = 'audio_volume';
  
  // Durations
  static const Duration snackBarDuration = Duration(seconds: 3);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration pageTransitionDuration = Duration(milliseconds: 400);
  static const Duration autoHideControlsDelay = Duration(seconds: 5);
  
  // Download Configuration
  static const int maxParallelDownloads = 5;
  static const int defaultParallelDownloads = 3;
  static const int downloadTimeoutSeconds = 60;
  static const int downloadChunkSize = 8192; // 8KB
  
  // Network
  static const Duration networkTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  
  // Size Limits
  static const int maxFilenameLength = 200;
  static const int maxPlaylistSize = 1000;
  
  // Quality Settings
  static const Map<String, int> videoQualityMap = {
    'low': 360,
    'medium': 720,
    'high': 1080,
    'auto': 0,
  };
  
  static const Map<String, int> audioQualityMap = {
    'low': 96,
    'medium': 192,
    'high': 320,
  };
  
  // Playback Speeds
  static const List<double> playbackSpeeds = [0.75, 1.0, 1.25, 1.5, 2.0];
  
  // Locale
  static const String defaultLocale = 'ar_EG';
  static const String defaultLanguage = 'ar';
  
  // Animation Curves
  static const double animationCurveValue = 0.5;
  
  // Notification IDs
  static const int audioNotificationId = 100;
  static const int downloadNotificationId = 200;
  static const int foregroundServiceNotificationId = 300;
}

/// Regular Expressions for validation
class RegexPatterns {
  static final RegExp youtubeUrl = RegExp(
    r'(https?://)?(www\.)?(youtube|youtu|youtube-nocookie)\.(com|be)',
    caseSensitive: false,
  );
  
  static final RegExp url = RegExp(
    r'https?://[^\s]+',
    caseSensitive: false,
  );
  
  static final RegExp email = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  
  static final RegExp filename = RegExp(
    r'^[a-zA-Z0-9._\-() ]+$',
  );
}

/// Error Messages
class ErrorMessages {
  // Network Errors
  static const String noInternet = 'لا توجد اتصالية بالإنترنت';
  static const String networkTimeout = 'انتهت مهلة الاتصال';
  static const String invalidUrl = 'رابط غير صحيح';
  
  // Download Errors
  static const String downloadFailed = 'فشل التحميل';
  static const String downloadNotFound = 'الملف غير موجود';
  static const String storageFull = 'مساحة التخزين ممتلئة';
  static const String invalidFilename = 'اسم الملف غير صحيح';
  
  // Permission Errors
  static const String permissionStorageRequired = 'مطلوب إذن الوصول للتخزين';
  static const String permissionAudioRequired = 'مطلوب إذن الوصول للصوت';
  static const String permissionNotificationRequired = 'مطلوب إذن الإشعارات';
  
  // Playback Errors
  static const String playbackFailed = 'فشل التشغيل';
  static const String unsupportedFormat = 'صيغة غير مدعومة';
  static const String mediaNotFound = 'الوسيط غير موجود';
  
  // Database Errors
  static const String databaseError = 'خطأ في قاعدة البيانات';
  static const String dataNotFound = 'البيانات غير موجودة';
  
  // Generic Errors
  static const String unknownError = 'حدث خطأ غير متوقع';
  static const String tryAgainLater = 'حاول لاحقاً';
}

/// Success Messages
class SuccessMessages {
  static const String downloadStarted = 'بدأ التحميل';
  static const String downloadCompleted = 'تم التحميل بنجاح';
  static const String playlistCreated = 'تم إنشاء قائمة التشغيل';
  static const String settingsSaved = 'تم حفظ الإعدادات';
  static const String itemDeleted = 'تم الحذف بنجاح';
  static const String itemAdded = 'تمت الإضافة بنجاح';
}

/// Log Tags
class LogTags {
  static const String audio = '[AUDIO]';
  static const String download = '[DOWNLOAD]';
  static const String database = '[DATABASE]';
  static const String network = '[NETWORK]';
  static const String ui = '[UI]';
  static const String permission = '[PERMISSION]';
  static const String settings = '[SETTINGS]';
}
