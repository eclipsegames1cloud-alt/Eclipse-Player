import 'package:get/get.dart';
import '../models/extended_models.dart';
import '../services/database_helper.dart';
import '../utils/constants.dart';

/// ✨ IMPROVED: Advanced video management with search, sort, and favorites
/// تحسين: إدارة متقدمة للفيديوهات مع البحث والفرز والمفضلة
class VideoController extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  
  // ✨ IMPROVED: Video lists with reactive updates
  final allVideos = RxList<MediaItem>();
  final filteredVideos = RxList<MediaItem>();
  final favoriteVideos = RxList<MediaItem>();
  
  // ✨ IMPROVED: Search and filter state
  final searchQuery = ''.obs;
  final sortBy = 'name'.obs; // 'name', 'date', 'recent'
  final filterType = 'all'.obs; // 'all', 'video', 'audio'
  final isSearching = false.obs;
  
  // ✨ IMPROVED: Loading state
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // تحسين: تحميل الفيديوهات عند البدء
    loadVideos();
    
    // تحسين: مراقبة البحث وتحديث النتائج
    ever(searchQuery, (_) => _applyFilters());
    ever(sortBy, (_) => _applySorting());
    ever(filterType, (_) => _applyFilters());
  }

  /// ✨ IMPROVED: Load all videos from database
  /// تحسين: تحميل جميع الفيديوهات من قاعدة البيانات
  Future<void> loadVideos() async {
    try {
      isLoading.value = true;
      final videos = await _dbHelper.getAllMediaItems();
      allVideos.value = videos;
      
      // تحسين: تحميل المفضلة
      await _loadFavorites();
      
      // تحسين: تطبيق الفرز الافتراضي
      _applySorting();
      
      print('${LogTags.settings} تم تحميل ${videos.length} فيديو');
      isLoading.value = false;
    } catch (e) {
      print('${LogTags.settings} خطأ في تحميل الفيديوهات: $e');
      isLoading.value = false;
    }
  }

  /// ✨ IMPROVED: Load favorite videos
  /// تحسين: تحميل الفيديوهات المفضلة
  Future<void> _loadFavorites() async {
    try {
      // تحسين: جلب الفيديوهات المفضلة (يمكن إضافة جدول منفصل لاحقاً)
      favoriteVideos.value = allVideos.where((video) {
        // TODO: إضافة حقل isFavorite للنموذج
        return false; // سيتم تحديثه
      }).toList();
    } catch (e) {
      print('${LogTags.settings} خطأ في تحميل المفضلة: $e');
    }
  }

  /// ✨ IMPROVED: Search videos with real-time filtering
  /// تحسين: البحث عن الفيديوهات مع التحديث الفوري
  void searchVideos(String query) {
    searchQuery.value = query;
    isSearching.value = query.isNotEmpty;
  }

  /// ✨ IMPROVED: Apply search and type filters
  /// تحسين: تطبيق البحث والفلترة
  void _applyFilters() {
    try {
      var filtered = allVideos.where((video) {
        // تحسين: البحث في الاسم والقناة
        final matchesSearch = searchQuery.isEmpty ||
            video.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            (video.channel?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false);
        
        // تحسين: تطبيق الفلترة حسب النوع
        final matchesType = filterType.value == 'all' ||
            (filterType.value == 'video' && video.type == MediaType.video) ||
            (filterType.value == 'audio' && video.type == MediaType.audio);
        
        return matchesSearch && matchesType;
      }).toList();
      
      filteredVideos.value = filtered;
      _applySorting();
    } catch (e) {
      print('${LogTags.settings} خطأ في الفلترة: $e');
    }
  }

  /// ✨ IMPROVED: Sort videos by name, date, or recent
  /// تحسين: فرز الفيديوهات حسب الاسم أو التاريخ أو الأخيرة
  void _applySorting() {
    try {
      final toSort = filteredVideos.isEmpty ? allVideos : filteredVideos;
      
      switch (sortBy.value) {
        case 'name':
          // تحسين: فرز حسب الاسم (أبجدي)
          toSort.sort((a, b) => a.title.compareTo(b.title));
          break;
        case 'date':
          // تحسين: فرز حسب تاريخ الإضافة (الأحدث أولاً)
          toSort.sort((a, b) => b.addedDate.compareTo(a.addedDate));
          break;
        case 'recent':
          // تحسين: فرز حسب آخر عرض (إذا توفر)
          // toSort.sort((a, b) => b.lastPlayed.compareTo(a.lastPlayed));
          break;
        default:
          break;
      }
      
      if (filteredVideos.isEmpty) {
        allVideos.value = toSort;
      } else {
        filteredVideos.value = toSort;
      }
    } catch (e) {
      print('${LogTags.settings} خطأ في الفرز: $e');
    }
  }

  /// ✨ IMPROVED: Toggle favorite status
  /// تحسين: إضافة/إزالة من المفضلة
  Future<void> toggleFavorite(MediaItem video) async {
    try {
      final isFavorite = favoriteVideos.contains(video);
      
      if (isFavorite) {
        favoriteVideos.remove(video);
        print('${LogTags.settings} تم إزالة من المفضلة: ${video.title}');
      } else {
        favoriteVideos.add(video);
        print('${LogTags.settings} تم إضافة للمفضلة: ${video.title}');
      }
      
      // تحسين: حفظ في قاعدة البيانات (يمكن إضافة جدول منفصل)
      // await _dbHelper.updateMediaItem(video);
    } catch (e) {
      print('${LogTags.settings} خطأ في تحديث المفضلة: $e');
    }
  }

  /// ✨ IMPROVED: Add new video to database
  /// تحسين: إضافة فيديو جديد
  Future<void> addVideo(MediaItem video) async {
    try {
      await _dbHelper.addMediaItem(video);
      allVideos.add(video);
      _applyFilters();
      print('${LogTags.settings} تم إضافة فيديو: ${video.title}');
    } catch (e) {
      print('${LogTags.settings} خطأ في إضافة الفيديو: $e');
    }
  }

  /// ✨ IMPROVED: Delete video from database and list
  /// تحسين: حذف الفيديو
  Future<void> deleteVideo(MediaItem video) async {
    try {
      await _dbHelper.deleteMediaItem(video.id);
      allVideos.remove(video);
      favoriteVideos.remove(video);
      filteredVideos.remove(video);
      print('${LogTags.settings} تم حذف الفيديو: ${video.title}');
    } catch (e) {
      print('${LogTags.settings} خطأ في حذف الفيديو: $e');
    }
  }

  /// ✨ IMPROVED: Clear search
  /// تحسين: مسح البحث
  void clearSearch() {
    searchQuery.value = '';
    isSearching.value = false;
    _applyFilters();
  }

  /// ✨ IMPROVED: Get total count of videos
  /// تحسين: الحصول على عدد الفيديوهات
  int getTotalCount() => allVideos.length;
  
  int getFilteredCount() => filteredVideos.length;
  
  int getFavoriteCount() => favoriteVideos.length;

  /// ✨ IMPROVED: Get statistics
  /// تحسين: إحصائيات الفيديوهات
  Map<String, int> getStatistics() {
    final videos = allVideos.where((v) => v.type == MediaType.video).length;
    final audios = allVideos.where((v) => v.type == MediaType.audio).length;
    
    return {
      'total': allVideos.length,
      'videos': videos,
      'audios': audios,
      'favorites': favoriteVideos.length,
    };
  }

  /// ✨ IMPROVED: Set sort method
  /// تحسين: تعيين طريقة الفرز
  void setSortBy(String method) {
    sortBy.value = method;
  }

  /// ✨ IMPROVED: Set filter type
  /// تحسين: تعيين نوع الفلتر
  void setFilterType(String type) {
    filterType.value = type;
  }
}
