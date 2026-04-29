import 'package:get/get.dart';
import 'dart:io';
import '../models/extended_models.dart';
import '../services/download_manager.dart';

class DownloadController extends GetxController {
  late DownloadManager downloadManager;
  
  // Observable Lists
  final downloadQueue = RxList<DownloadItem>();
  final completedDownloads = RxList<DownloadItem>();
  final failedDownloads = RxList<DownloadItem>();
  
  // Stats
  final totalDownloading = 0.obs;
  final totalCompleted = 0.obs;
  final totalFailed = 0.obs;
  final totalSize = 0.obs;
  final downloadedSize = 0.obs;
  final overallSpeed = 0.0.obs;
  
  // Settings
  final wifiOnlyMode = false.obs;
  final parallelDownloads = 3.obs;
  final maxDownloadSpeed = 0.obs; // KB/s, 0 = unlimited
  
  @override
  void onInit() {
    super.onInit();
    downloadManager = DownloadManager(this);
    _initializeDownloadManager();
  }
  
  void _initializeDownloadManager() {
    // Initialize and restore previous downloads
    _loadDownloadsFromDatabase();
  }
  
  Future<void> addToQueue(MediaItem mediaItem, MediaType type) async {
    final downloadItem = DownloadItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      mediaId: mediaItem.id,
      title: mediaItem.title,
      filePath: '',
      totalSize: 0,
      type: type,
      status: DownloadStatus.queued,
    );
    
    downloadQueue.add(downloadItem);
    
    // Start download if within parallel limit
    if (totalDownloading.value < parallelDownloads.value) {
      _startDownload(downloadItem);
    }
  }
  
  Future<void> _startDownload(DownloadItem item) async {
    totalDownloading.value++;
    item.status = DownloadStatus.downloading;
    downloadQueue.refresh();
    
    try {
      await downloadManager.downloadMedia(item);
      item.status = DownloadStatus.completed;
      item.endTime = DateTime.now();
      completedDownloads.add(item);
      totalCompleted.value++;
    } catch (e) {
      item.status = DownloadStatus.failed;
      item.errorMessage = e.toString();
      failedDownloads.add(item);
      totalFailed.value++;
    } finally {
      totalDownloading.value--;
      downloadQueue.remove(item);
      
      // Start next queued download
      final nextQueued = downloadQueue.firstWhereOrNull(
        (item) => item.status == DownloadStatus.queued,
      );
      if (nextQueued != null) {
        _startDownload(nextQueued);
      }
    }
  }
  
  void pauseDownload(DownloadItem item) {
    item.status = DownloadStatus.paused;
    downloadManager.pauseDownload(item.id);
    downloadQueue.refresh();
  }
  
  void resumeDownload(DownloadItem item) {
    item.status = DownloadStatus.downloading;
    downloadManager.resumeDownload(item.id);
    downloadQueue.refresh();
  }
  
  void cancelDownload(DownloadItem item) {
    downloadManager.cancelDownload(item.id);
    downloadQueue.remove(item);
    totalDownloading.value--;
  }
  
  void retryFailedDownload(DownloadItem item) {
    item.status = DownloadStatus.queued;
    item.retryCount++;
    item.downloadedSize = 0;
    item.errorMessage = null;
    failedDownloads.remove(item);
    downloadQueue.add(item);
    
    if (totalDownloading.value < parallelDownloads.value) {
      _startDownload(item);
    }
  }
  
  void clearCompleted() {
    completedDownloads.clear();
    totalCompleted.value = 0;
  }
  
  void clearFailed() {
    failedDownloads.clear();
    totalFailed.value = 0;
  }
  
  double getOverallProgress() {
    if (totalSize.value == 0) return 0;
    return (downloadedSize.value / totalSize.value) * 100;
  }
  
  void updateDownloadProgress(String downloadId, int downloaded, int total) {
    final item = downloadQueue.firstWhereOrNull((item) => item.id == downloadId);
    if (item != null) {
      item.downloadedSize = downloaded;
      if (item.totalSize == 0) item.totalSize = total;
      downloadQueue.refresh();
      _updateStats();
    }
  }
  
  void _updateStats() {
    totalSize.value = downloadQueue.fold(0, (sum, item) => sum + item.totalSize);
    downloadedSize.value = downloadQueue.fold(0, (sum, item) => sum + item.downloadedSize);
    
    // Calculate overall speed
    double speed = 0;
    for (var item in downloadQueue) {
      if (item.status == DownloadStatus.downloading) {
        speed += item.downloadSpeed;
      }
    }
    overallSpeed.value = speed;
  }
  
  void _loadDownloadsFromDatabase() {
    // Load from database
    // Placeholder implementation
  }
  
  void setWifiOnly(bool value) {
    wifiOnlyMode.value = value;
  }
  
  void setParallelDownloads(int count) {
    parallelDownloads.value = count;
  }
  
  void setDownloadSpeedLimit(int speedKbs) {
    maxDownloadSpeed.value = speedKbs;
  }
}
