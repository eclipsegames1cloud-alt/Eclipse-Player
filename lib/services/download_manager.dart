import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/extended_models.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// ENHANCED DOWNLOAD MANAGER SERVICE
/// Manages downloads with queue, progress, retry logic, and speed tracking
/// ═══════════════════════════════════════════════════════════════════════════

class DownloadManager extends GetxController {
  late Dio _dio;

  // ─────────────────────────────────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────────────────────────────────

  final activeDownloads = <String, DownloadItem>{}.obs;
  final downloadQueue = <DownloadItem>[].obs;
  final completedDownloads = <DownloadItem>[].obs;
  final failedDownloads = <DownloadItem>[].obs;

  final isDownloading = false.obs;
  final totalDownloadSpeed = 0.0.obs; // bytes per second

  // Configuration
  int maxParallelDownloads = 3;
  int retryAttempts = 3;
  bool wifiOnlyDownloads = false;

  @override
  void onInit() {
    super.onInit();
    _initializeDio();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // INITIALIZATION
  // ─────────────────────────────────────────────────────────────────────────

  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // DOWNLOAD QUEUE MANAGEMENT
  // ─────────────────────────────────────────────────────────────────────────

  /// Add download to queue
  Future<void> addToQueue(DownloadItem download) async {
    try {
      downloadQueue.add(download);
      print('📥 Added to queue: ${download.title}');

      // Start processing queue
      _processQueue();
    } catch (e) {
      print('✗ Error adding to queue: $e');
    }
  }

  /// Process download queue
  void _processQueue() {
    // Start downloads while we haven't exceeded max parallel
    while (activeDownloads.length < maxParallelDownloads &&
        downloadQueue.isNotEmpty) {
      final download = downloadQueue.removeAt(0);
      _startDownload(download);
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // DOWNLOAD EXECUTION
  // ─────────────────────────────────────────────────────────────────────────

  /// Start individual download
  Future<void> _startDownload(DownloadItem download) async {
    try {
      activeDownloads[download.id] = download;
      download.status = DownloadStatus.downloading;
      isDownloading.value = true;

      print('▶ Starting download: ${download.title}');

      await _dio.download(
        download.url,
        download.filePath,
        onReceiveProgress: (received, total) {
          _onDownloadProgress(download.id, received, total);
        },
        deleteOnError: !download.status.toString().contains('paused'),
      );

      // Download completed
      download.status = DownloadStatus.completed;
      download.endTime = DateTime.now();
      activeDownloads.remove(download.id);
      completedDownloads.add(download);

      print('✓ Download completed: ${download.title}');
      Get.snackbar(
        'اكتمل التحميل',
        '${download.title} تم تحميله بنجاح',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );

      // Process next in queue
      _processQueue();
    } on DioException catch (e) {
      await _handleDownloadError(download, e);
    } catch (e) {
      download.status = DownloadStatus.failed;
      download.errorMessage = e.toString();
      activeDownloads.remove(download.id);
      failedDownloads.add(download);

      print('✗ Download error: $e');
      Get.snackbar(
        'خطأ في التحميل',
        '${download.title}: $e',
        snackPosition: SnackPosition.BOTTOM,
      );

      _processQueue();
    }
  }

  /// Handle download errors with retry logic
  Future<void> _handleDownloadError(DownloadItem download, DioException e) async {
    download.retryCount++;

    if (download.retryCount < retryAttempts) {
      print('🔄 Retrying download (${download.retryCount}/$retryAttempts): ${download.title}');

      // Re-queue for retry
      downloadQueue.insert(0, download);
      download.status = DownloadStatus.queued;
      activeDownloads.remove(download.id);

      // Brief delay before retry
      await Future.delayed(Duration(seconds: 2));
      _processQueue();
    } else {
      // Failed after all retries
      download.status = DownloadStatus.failed;
      download.errorMessage = e.message ?? 'Unknown error';
      activeDownloads.remove(download.id);
      failedDownloads.add(download);

      print('✗ Download failed after retries: ${download.title}');
      Get.snackbar(
        'فشل التحميل',
        '${download.title}: لم يتمكن من الاتصال',
        snackPosition: SnackPosition.BOTTOM,
      );

      _processQueue();
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // PROGRESS TRACKING
  // ─────────────────────────────────────────────────────────────────────────

  /// Track download progress
  void _onDownloadProgress(String downloadId, int received, int total) {
    if (activeDownloads.containsKey(downloadId)) {
      final download = activeDownloads[downloadId]!;
      download.downloadedSize = received;
      download.totalSize = total;

      // Calculate speed
      final duration =
          DateTime.now().difference(download.startTime).inSeconds;
      if (duration > 0) {
        download.speed = (received / duration).toInt(); // bytes/sec
      }

      activeDownloads[downloadId] = download;
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // DOWNLOAD CONTROL
  // ─────────────────────────────────────────────────────────────────────────

  /// Pause download
  Future<void> pauseDownload(String downloadId) async {
    try {
      if (activeDownloads.containsKey(downloadId)) {
        final download = activeDownloads[downloadId]!;
        download.status = DownloadStatus.paused;
        print('⏸ Paused: ${download.title}');

        // Move to queue head for resume
        downloadQueue.insert(0, download);
        activeDownloads.remove(downloadId);
        _processQueue();
      }
    } catch (e) {
      print('✗ Error pausing download: $e');
    }
  }

  /// Resume download
  Future<void> resumeDownload(String downloadId) async {
    try {
      final download = activeDownloads.containsKey(downloadId)
          ? activeDownloads[downloadId]
          : failedDownloads.firstWhereOrNull((d) => d.id == downloadId) ??
              completedDownloads.firstWhereOrNull((d) => d.id == downloadId);

      if (download != null) {
        download.status = DownloadStatus.queued;
        download.retryCount = 0; // Reset retry count for manual resume
        downloadQueue.insert(0, download);
        print('▶ Resumed: ${download.title}');
        _processQueue();
      }
    } catch (e) {
      print('✗ Error resuming download: $e');
    }
  }

  /// Cancel download
  Future<void> cancelDownload(String downloadId) async {
    try {
      if (activeDownloads.containsKey(downloadId)) {
        final download = activeDownloads[downloadId]!;
        download.status = DownloadStatus.idle;

        // Remove from active
        activeDownloads.remove(downloadId);

        // Delete file if requested in settings
        // TODO: Check deleteIncompleteOnCancel setting
        print('✗ Cancelled: ${download.title}');

        _processQueue();
      } else {
        // Remove from queue
        downloadQueue.removeWhere((d) => d.id == downloadId);
      }
    } catch (e) {
      print('✗ Error cancelling download: $e');
    }
  }

  /// Retry failed download
  Future<void> retryDownload(String downloadId) async {
    try {
      final download =
          failedDownloads.firstWhereOrNull((d) => d.id == downloadId);

      if (download != null) {
        download.status = DownloadStatus.queued;
        download.retryCount = 0;
        download.errorMessage = null;

        failedDownloads.removeWhere((d) => d.id == downloadId);
        downloadQueue.add(download);

        print('🔄 Retrying failed download: ${download.title}');
        _processQueue();
      }
    } catch (e) {
      print('✗ Error retrying download: $e');
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // STATISTICS & UTILITIES
  // ─────────────────────────────────────────────────────────────────────────

  /// Get download statistics
  Map<String, dynamic> getDownloadStats() {
    return {
      'active': activeDownloads.length,
      'queued': downloadQueue.length,
      'completed': completedDownloads.length,
      'failed': failedDownloads.length,
      'totalSize': _calculateTotalSize(),
      'downloadedSize': _calculateDownloadedSize(),
      'averageSpeed': _calculateAverageSpeed(),
    };
  }

  int _calculateTotalSize() {
    return activeDownloads.values.fold(
      0,
      (sum, d) => sum + d.totalSize,
    );
  }

  int _calculateDownloadedSize() {
    return activeDownloads.values.fold(
      0,
      (sum, d) => sum + d.downloadedSize,
    );
  }

  double _calculateAverageSpeed() {
    if (activeDownloads.isEmpty) return 0;
    final totalSpeed =
        activeDownloads.values.fold<int>(0, (sum, d) => sum + (d.speed ?? 0));
    return (totalSpeed / activeDownloads.length).toDouble();
  }

  /// Format file size
  static String formatFileSize(int bytes) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = (bytes.toString().length / 3).ceil();
    return '${(bytes / (1000 ^ i)).toStringAsFixed(2)} ${suffixes[i]}';
  }

  /// Format download speed
  static String formatSpeed(double bytesPerSecond) {
    return '${formatFileSize(bytesPerSecond.toInt())}/s';
  }

  /// Estimate time remaining
  static String estimateTimeRemaining(
    int remainingBytes,
    double bytesPerSecond,
  ) {
    if (bytesPerSecond <= 0) return '--:--';
    final seconds = (remainingBytes / bytesPerSecond).toInt();
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    } else {
      return '$minutes:${secs.toString().padLeft(2, '0')}';
    }
  }

  /// Get download progress percentage
  double getDownloadProgress(String downloadId) {
    if (activeDownloads.containsKey(downloadId)) {
      final download = activeDownloads[downloadId]!;
      if (download.totalSize > 0) {
        return download.downloadedSize / download.totalSize;
      }
    }
    return 0.0;
  }

  /// Clear completed downloads
  void clearCompleted() {
    completedDownloads.clear();
    print('✓ Cleared completed downloads');
  }

  /// Clear failed downloads
  void clearFailed() {
    failedDownloads.clear();
    print('✓ Cleared failed downloads');
  }

  @override
  void onClose() {
    _dio.close();
    super.onClose();
  }
}

// Extension for DownloadItem
extension DownloadItemExtension on DownloadItem {
  int? _speed;

  int? get speed => _speed;
  set speed(int? value) => _speed = value;

  String? _url;
  String get url => _url ?? '';
  set url(String value) => _url = value;

  String get progressPercentage {
    if (totalSize <= 0) return '0%';
    return '${((downloadedSize / totalSize) * 100).toStringAsFixed(1)}%';
  }

  String get speedFormatted {
    if (speed == null || speed == 0) return '--';
    return EnhancedDownloadManager.formatSpeed(speed!.toDouble());
  }

  String get remainingTime {
    if (speed == null || speed == 0) return '--:--';
    final remaining = totalSize - downloadedSize;
    return EnhancedDownloadManager.estimateTimeRemaining(
      remaining,
      (speed ?? 0).toDouble(),
    );
  }

  String get sizeFormatted {
    return '${EnhancedDownloadManager.formatFileSize(downloadedSize)} / '
        '${EnhancedDownloadManager.formatFileSize(totalSize)}';
  }
}
