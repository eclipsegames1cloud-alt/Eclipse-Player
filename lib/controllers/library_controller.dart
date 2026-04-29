import 'package:get/get.dart';
import '../models/extended_models.dart';
import '../services/database_helper.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// ENHANCED LIBRARY CONTROLLER
/// Manages audio library with search, filtering, recently played, etc.
/// ═══════════════════════════════════════════════════════════════════════════

class LibraryController extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // ─────────────────────────────────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────────────────────────────────

  final allAudioItems = <MediaItem>[].obs;
  final filteredAudioItems = <MediaItem>[].obs;
  final recentlyPlayedAudio = <MediaItem>[].obs;
  final favoriteAudio = <MediaItem>[].obs;

  final searchQuery = ''.obs;
  final selectedSort = 'name'.obs; // name, date, duration
  final selectedFilter = 'all'.obs; // all, favorites, recently_played
  final isLoading = false.obs;
  final isEmpty = true.obs;

  // ─────────────────────────────────────────────────────────────────────────
  // AUDIO IMAGE MANAGEMENT
  // ─────────────────────────────────────────────────────────────────────────

  final audioImages = <String, String>{}.obs; // audioId -> imagePath

  @override
  void onInit() {
    super.onInit();
    loadLibrary();
    
    // React to search query changes
    debounce(
      searchQuery,
      (_) => _applyFiltersAndSort(),
      time: Duration(milliseconds: 500),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LIBRARY LOADING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Load all audio items from database
  Future<void> loadLibrary() async {
    try {
      isLoading.value = true;
      
      // Load all audio
      final audioList = await _dbHelper.getAllMediaItems();
      allAudioItems.value = audioList;
      
      // Load recently played
      recentlyPlayedAudio.value = await _getRecentlyPlayed();
      
      // Load favorites
      favoriteAudio.value = await _getFavorites();
      
      // Apply initial filters
      _applyFiltersAndSort();
      
      isEmpty.value = allAudioItems.isEmpty;
      print('✓ Library loaded: ${allAudioItems.length} items');
    } catch (e) {
      print('✗ Error loading library: $e');
      isEmpty.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SEARCH & FILTER
  // ═══════════════════════════════════════════════════════════════════════════

  /// Update search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  /// Apply filters and sorting
  void _applyFiltersAndSort() {
    var results = _getFilteredList();
    results = _applySorting(results);
    filteredAudioItems.value = results;
  }

  /// Get filtered list based on current filter selection
  List<MediaItem> _getFilteredList() {
    final source = selectedFilter.value == 'favorites'
        ? favoriteAudio
        : selectedFilter.value == 'recently_played'
            ? recentlyPlayedAudio
            : allAudioItems;

    // Apply search query
    if (searchQuery.value.isEmpty) {
      return source.toList();
    }

    final query = searchQuery.value.toLowerCase();
    return source
        .where((item) =>
            item.title.toLowerCase().contains(query) ||
            (item.channel?.toLowerCase().contains(query) ?? false))
        .toList();
  }

  /// Apply sorting to results
  List<MediaItem> _applySorting(List<MediaItem> items) {
    final sorted = List<MediaItem>.from(items);

    switch (selectedSort.value) {
      case 'name':
        sorted.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'date':
        sorted.sort((a, b) => b.addedDate.compareTo(a.addedDate));
        break;
      case 'duration':
        sorted.sort((a, b) => b.duration.compareTo(a.duration));
        break;
      default:
        break;
    }

    return sorted;
  }

  /// Change sort option
  void setSortBy(String sortBy) {
    selectedSort.value = sortBy;
    _applyFiltersAndSort();
  }

  /// Change filter option
  void setFilter(String filter) {
    selectedFilter.value = filter;
    _applyFiltersAndSort();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // RECENTLY PLAYED
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get recently played audio (limit 20)
  Future<List<MediaItem>> _getRecentlyPlayed() async {
    try {
      // This would query recently played from database
      // For now, return empty list - implement with proper DB schema
      return [];
    } catch (e) {
      print('✗ Error loading recently played: $e');
      return [];
    }
  }

  /// Mark audio as recently played
  Future<void> markAsRecentlyPlayed(MediaItem audio) async {
    try {
      // Update in database
      // Remove from recently played if exists
      recentlyPlayedAudio.removeWhere((item) => item.id == audio.id);
      
      // Add to top
      recentlyPlayedAudio.insert(0, audio);
      
      // Keep only last 50
      if (recentlyPlayedAudio.length > 50) {
        recentlyPlayedAudio.removeRange(50, recentlyPlayedAudio.length);
      }
      
      // Persist to database
      // TODO: Add recently_played table to database
    } catch (e) {
      print('✗ Error marking as recently played: $e');
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FAVORITES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get favorite audio
  Future<List<MediaItem>> _getFavorites() async {
    try {
      // This would query favorites from database
      return [];
    } catch (e) {
      print('✗ Error loading favorites: $e');
      return [];
    }
  }

  /// Toggle favorite status
  Future<void> toggleFavorite(MediaItem audio) async {
    try {
      final isFavorite = favoriteAudio.any((item) => item.id == audio.id);
      
      if (isFavorite) {
        favoriteAudio.removeWhere((item) => item.id == audio.id);
      } else {
        favoriteAudio.add(audio);
      }
      
      // Persist to database
      // TODO: Add favorites table to database
      
      _applyFiltersAndSort();
    } catch (e) {
      print('✗ Error toggling favorite: $e');
    }
  }

  /// Check if audio is favorite
  bool isFavorite(String audioId) {
    return favoriteAudio.any((item) => item.id == audioId);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // AUDIO IMAGE MANAGEMENT
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get image for audio
  String? getAudioImage(String audioId) {
    return audioImages[audioId];
  }

  /// Set custom image for audio
  Future<void> setAudioImage(String audioId, String imagePath) async {
    try {
      audioImages[audioId] = imagePath;
      
      // Update in database
      // TODO: Add image_path field to media table
      
      print('✓ Image set for audio: $audioId');
    } catch (e) {
      print('✗ Error setting audio image: $e');
      Get.snackbar(
        'خطأ',
        'فشل تعيين الصورة: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Remove image for audio
  Future<void> removeAudioImage(String audioId) async {
    try {
      audioImages.remove(audioId);
      
      // Update in database
      // TODO: Clear image_path in database
      
      print('✓ Image removed for audio: $audioId');
    } catch (e) {
      print('✗ Error removing audio image: $e');
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LIBRARY MANAGEMENT
  // ═══════════════════════════════════════════════════════════════════════════

  /// Add audio to library
  Future<void> addAudio(MediaItem audio) async {
    try {
      await _dbHelper.insertMediaItem(audio);
      await loadLibrary();
      Get.snackbar(
        'تم الإضافة',
        '${audio.title} تم إضافته إلى المكتبة',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل إضافة الملف: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Delete audio from library
  Future<void> deleteAudio(String audioId) async {
    try {
      await _dbHelper.deleteMediaItem(audioId);
      audioImages.remove(audioId);
      await loadLibrary();
      Get.snackbar(
        'تم الحذف',
        'تم حذف الملف من المكتبة',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل حذف الملف: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Batch delete multiple audio items
  Future<void> batchDelete(List<String> audioIds) async {
    try {
      for (final id in audioIds) {
        await _dbHelper.deleteMediaItem(id);
        audioImages.remove(id);
      }
      await loadLibrary();
      Get.snackbar(
        'تم الحذف',
        'تم حذف ${audioIds.length} ملف',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل الحذف: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get statistics
  Map<String, dynamic> getStatistics() {
    return {
      'totalAudio': allAudioItems.length,
      'totalDuration': _getTotalDuration(),
      'favorites': favoriteAudio.length,
      'recentlyPlayed': recentlyPlayedAudio.length,
    };
  }

  /// Calculate total duration of all audio
  Duration _getTotalDuration() {
    return allAudioItems.fold(
      Duration.zero,
      (prev, item) => prev + item.duration,
    );
  }

  /// Get audio by ID
  MediaItem? getAudioById(String id) {
    try {
      return allAudioItems.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Refresh library
  Future<void> refresh() async {
    await loadLibrary();
  }
}
