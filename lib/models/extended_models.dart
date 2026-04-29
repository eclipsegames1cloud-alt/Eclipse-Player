import 'package:flutter/foundation.dart';

// Download Status Enum
enum DownloadStatus { idle, queued, downloading, paused, completed, failed }

enum MediaType { video, audio, unknown }

// Media Item Model
class MediaItem {
  final String id;
  final String title;
  final String url;
  final String? thumbnailUrl;
  final String? description;
  final Duration duration;
  final DateTime? uploadDate;
  final int? viewCount;
  final String? channel;
  final MediaType type;
  final DateTime addedDate;
  
  MediaItem({
    required this.id,
    required this.title,
    required this.url,
    this.thumbnailUrl,
    this.description,
    required this.duration,
    this.uploadDate,
    this.viewCount,
    this.channel,
    required this.type,
    DateTime? addedDate,
  }) : addedDate = addedDate ?? DateTime.now();
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'description': description,
      'duration': duration.inSeconds,
      'uploadDate': uploadDate?.toIso8601String(),
      'viewCount': viewCount,
      'channel': channel,
      'type': type.toString(),
      'addedDate': addedDate.toIso8601String(),
    };
  }
  
  factory MediaItem.fromMap(Map<String, dynamic> map) {
    return MediaItem(
      id: map['id'] ?? '',
      title: map['title'] ?? 'Unknown',
      url: map['url'] ?? '',
      thumbnailUrl: map['thumbnailUrl'],
      description: map['description'],
      duration: Duration(seconds: map['duration'] ?? 0),
      uploadDate: map['uploadDate'] != null ? DateTime.parse(map['uploadDate']) : null,
      viewCount: map['viewCount'],
      channel: map['channel'],
      type: map['type']?.toString().contains('audio') ?? false ? MediaType.audio : MediaType.video,
      addedDate: map['addedDate'] != null ? DateTime.parse(map['addedDate']) : null,
    );
  }
}

// Download Item Model
class DownloadItem {
  final String id;
  final String mediaId;
  final String title;
  final String filePath;
  final int totalSize;
  int downloadedSize;
  DownloadStatus status;
  final DateTime startTime;
  DateTime? endTime;
  final MediaType type;
  String? thumbnailPath;
  int retryCount;
  String? errorMessage;
  
  DownloadItem({
    required this.id,
    required this.mediaId,
    required this.title,
    required this.filePath,
    required this.totalSize,
    this.downloadedSize = 0,
    this.status = DownloadStatus.idle,
    DateTime? startTime,
    this.endTime,
    required this.type,
    this.thumbnailPath,
    this.retryCount = 0,
    this.errorMessage,
  }) : startTime = startTime ?? DateTime.now();
  
  double get progress => totalSize > 0 ? (downloadedSize / totalSize) * 100 : 0;
  
  double get progressDecimal => totalSize > 0 ? downloadedSize / totalSize : 0;
  
  Duration get elapsedTime {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime);
  }
  
  double get downloadSpeed {
    final elapsed = elapsedTime.inSeconds;
    if (elapsed == 0 || downloadedSize == 0) return 0;
    return downloadedSize / elapsed / 1024 / 1024; // MB/s
  }
  
  Duration get estimatedTimeRemaining {
    if (downloadSpeed <= 0) return Duration.zero;
    final remainingSize = totalSize - downloadedSize;
    final seconds = (remainingSize / downloadSpeed / 1024 / 1024).toInt();
    return Duration(seconds: seconds);
  }
  
  String get totalSizeFormatted => _formatBytes(totalSize);
  String get downloadedSizeFormatted => _formatBytes(downloadedSize);
  String get downloadSpeedFormatted => '${downloadSpeed.toStringAsFixed(2)} MB/s';
  String get estimatedTimeFormated {
    final remaining = estimatedTimeRemaining;
    if (remaining.inHours > 0) {
      return '${remaining.inHours}h ${remaining.inMinutes % 60}m';
    } else if (remaining.inMinutes > 0) {
      return '${remaining.inMinutes}m ${remaining.inSeconds % 60}s';
    } else {
      return '${remaining.inSeconds}s';
    }
  }
  
  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / 1024 / 1024).toStringAsFixed(2)} MB';
    return '${(bytes / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mediaId': mediaId,
      'title': title,
      'filePath': filePath,
      'totalSize': totalSize,
      'downloadedSize': downloadedSize,
      'status': status.toString(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'type': type.toString(),
      'thumbnailPath': thumbnailPath,
      'retryCount': retryCount,
      'errorMessage': errorMessage,
    };
  }
  
  factory DownloadItem.fromMap(Map<String, dynamic> map) {
    return DownloadItem(
      id: map['id'] ?? '',
      mediaId: map['mediaId'] ?? '',
      title: map['title'] ?? 'Unknown',
      filePath: map['filePath'] ?? '',
      totalSize: map['totalSize'] ?? 0,
      downloadedSize: map['downloadedSize'] ?? 0,
      status: _parseDownloadStatus(map['status']),
      startTime: map['startTime'] != null ? DateTime.parse(map['startTime']) : null,
      endTime: map['endTime'] != null ? DateTime.parse(map['endTime']) : null,
      type: map['type']?.toString().contains('audio') ?? false ? MediaType.audio : MediaType.video,
      thumbnailPath: map['thumbnailPath'],
      retryCount: map['retryCount'] ?? 0,
      errorMessage: map['errorMessage'],
    );
  }
  
  static DownloadStatus _parseDownloadStatus(String? status) {
    if (status == null) return DownloadStatus.idle;
    if (status.contains('downloading')) return DownloadStatus.downloading;
    if (status.contains('paused')) return DownloadStatus.paused;
    if (status.contains('completed')) return DownloadStatus.completed;
    if (status.contains('failed')) return DownloadStatus.failed;
    if (status.contains('queued')) return DownloadStatus.queued;
    return DownloadStatus.idle;
  }
}

// Playlist Model
class Playlist {
  final String id;
  final String name;
  final String? description;
  final List<String> mediaIds;
  final DateTime createdDate;
  DateTime lastModified;
  String? coverImagePath;
  
  Playlist({
    required this.id,
    required this.name,
    this.description,
    List<String>? mediaIds,
    DateTime? createdDate,
    DateTime? lastModified,
    this.coverImagePath,
  })  : mediaIds = mediaIds ?? [],
        createdDate = createdDate ?? DateTime.now(),
        lastModified = lastModified ?? DateTime.now();
  
  int get itemCount => mediaIds.length;
  
  void addMedia(String mediaId) {
    if (!mediaIds.contains(mediaId)) {
      mediaIds.add(mediaId);
      lastModified = DateTime.now();
    }
  }
  
  void removeMedia(String mediaId) {
    mediaIds.remove(mediaId);
    lastModified = DateTime.now();
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'mediaIds': mediaIds.join(','),
      'createdDate': createdDate.toIso8601String(),
      'lastModified': lastModified.toIso8601String(),
      'coverImagePath': coverImagePath,
    };
  }
  
  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      id: map['id'] ?? '',
      name: map['name'] ?? 'Playlist',
      description: map['description'],
      mediaIds: (map['mediaIds'] as String?)?.split(',') ?? [],
      createdDate: map['createdDate'] != null ? DateTime.parse(map['createdDate']) : null,
      lastModified: map['lastModified'] != null ? DateTime.parse(map['lastModified']) : null,
      coverImagePath: map['coverImagePath'],
    );
  }
}

// Audio Metadata Model
class AudioMetadata {
  final String mediaId;
  final String? customImagePath;
  final String? originalThumbnail;
  final DateTime? lastPlayed;
  int playCount;
  int likeCount;
  bool isFavorite;
  
  AudioMetadata({
    required this.mediaId,
    this.customImagePath,
    this.originalThumbnail,
    this.lastPlayed,
    this.playCount = 0,
    this.likeCount = 0,
    this.isFavorite = false,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'mediaId': mediaId,
      'customImagePath': customImagePath,
      'originalThumbnail': originalThumbnail,
      'lastPlayed': lastPlayed?.toIso8601String(),
      'playCount': playCount,
      'likeCount': likeCount,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }
  
  factory AudioMetadata.fromMap(Map<String, dynamic> map) {
    return AudioMetadata(
      mediaId: map['mediaId'] ?? '',
      customImagePath: map['customImagePath'],
      originalThumbnail: map['originalThumbnail'],
      lastPlayed: map['lastPlayed'] != null ? DateTime.parse(map['lastPlayed']) : null,
      playCount: map['playCount'] ?? 0,
      likeCount: map['likeCount'] ?? 0,
      isFavorite: (map['isFavorite'] ?? 0) == 1,
    );
  }
}

// Settings Model
class AppSettings {
  // Audio Settings
  bool audioBackgroundPlayback;
  bool audioAutoResume;
  String audioQuality; // low, medium, high
  bool audioNotificationsEnabled;
  
  // Video Settings
  bool videoAutoplay;
  String videoQuality; // low, medium, high, auto
  bool videoGestureSeek;
  bool videoGestureBrightness;
  
  // Download Settings
  bool downloadWifiOnly;
  int downloadParallelCount;
  String downloadStoragePath;
  int downloadSpeedLimit; // KB/s, 0 = unlimited
  
  // App Settings
  bool darkMode;
  String accentColor; // primary, secondary, accent
  String fontSize; // small, medium, large
  bool roundedCorners;
  
  // Notification Settings
  bool notificationsEnabled;
  bool notificationDownload;
  bool notificationMedia;
  
  // Smart Features
  bool resumeLastPlayback;
  bool smartSuggestions;
  bool autoLibraryOrganization;
  
  AppSettings({
    // Audio
    this.audioBackgroundPlayback = true,
    this.audioAutoResume = true,
    this.audioQuality = 'high',
    this.audioNotificationsEnabled = true,
    // Video
    this.videoAutoplay = false,
    this.videoQuality = 'auto',
    this.videoGestureSeek = true,
    this.videoGestureBrightness = true,
    // Download
    this.downloadWifiOnly = false,
    this.downloadParallelCount = 3,
    this.downloadStoragePath = '',
    this.downloadSpeedLimit = 0,
    // App
    this.darkMode = true,
    this.accentColor = 'primary',
    this.fontSize = 'medium',
    this.roundedCorners = true,
    // Notification
    this.notificationsEnabled = true,
    this.notificationDownload = true,
    this.notificationMedia = true,
    // Smart
    this.resumeLastPlayback = true,
    this.smartSuggestions = true,
    this.autoLibraryOrganization = true,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'audioBackgroundPlayback': audioBackgroundPlayback ? 1 : 0,
      'audioAutoResume': audioAutoResume ? 1 : 0,
      'audioQuality': audioQuality,
      'audioNotificationsEnabled': audioNotificationsEnabled ? 1 : 0,
      'videoAutoplay': videoAutoplay ? 1 : 0,
      'videoQuality': videoQuality,
      'videoGestureSeek': videoGestureSeek ? 1 : 0,
      'videoGestureBrightness': videoGestureBrightness ? 1 : 0,
      'downloadWifiOnly': downloadWifiOnly ? 1 : 0,
      'downloadParallelCount': downloadParallelCount,
      'downloadStoragePath': downloadStoragePath,
      'downloadSpeedLimit': downloadSpeedLimit,
      'darkMode': darkMode ? 1 : 0,
      'accentColor': accentColor,
      'fontSize': fontSize,
      'roundedCorners': roundedCorners ? 1 : 0,
      'notificationsEnabled': notificationsEnabled ? 1 : 0,
      'notificationDownload': notificationDownload ? 1 : 0,
      'notificationMedia': notificationMedia ? 1 : 0,
      'resumeLastPlayback': resumeLastPlayback ? 1 : 0,
      'smartSuggestions': smartSuggestions ? 1 : 0,
      'autoLibraryOrganization': autoLibraryOrganization ? 1 : 0,
    };
  }
  
  factory AppSettings.fromMap(Map<String, dynamic> map) {
    return AppSettings(
      audioBackgroundPlayback: (map['audioBackgroundPlayback'] ?? 1) == 1,
      audioAutoResume: (map['audioAutoResume'] ?? 1) == 1,
      audioQuality: map['audioQuality'] ?? 'high',
      audioNotificationsEnabled: (map['audioNotificationsEnabled'] ?? 1) == 1,
      videoAutoplay: (map['videoAutoplay'] ?? 0) == 1,
      videoQuality: map['videoQuality'] ?? 'auto',
      videoGestureSeek: (map['videoGestureSeek'] ?? 1) == 1,
      videoGestureBrightness: (map['videoGestureBrightness'] ?? 1) == 1,
      downloadWifiOnly: (map['downloadWifiOnly'] ?? 0) == 1,
      downloadParallelCount: map['downloadParallelCount'] ?? 3,
      downloadStoragePath: map['downloadStoragePath'] ?? '',
      downloadSpeedLimit: map['downloadSpeedLimit'] ?? 0,
      darkMode: (map['darkMode'] ?? 1) == 1,
      accentColor: map['accentColor'] ?? 'primary',
      fontSize: map['fontSize'] ?? 'medium',
      roundedCorners: (map['roundedCorners'] ?? 1) == 1,
      notificationsEnabled: (map['notificationsEnabled'] ?? 1) == 1,
      notificationDownload: (map['notificationDownload'] ?? 1) == 1,
      notificationMedia: (map['notificationMedia'] ?? 1) == 1,
      resumeLastPlayback: (map['resumeLastPlayback'] ?? 1) == 1,
      smartSuggestions: (map['smartSuggestions'] ?? 1) == 1,
      autoLibraryOrganization: (map['autoLibraryOrganization'] ?? 1) == 1,
    );
  }
}
