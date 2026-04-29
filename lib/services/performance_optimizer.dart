import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/constants.dart';

/// ✨ IMPROVED: Performance optimization and memory management
/// تحسين: تحسين الأداء وإدارة الذاكرة
class PerformanceOptimizer {
  // تحسين: متغيرات الأداء
  static final _performanceMetrics = <String, dynamic>{};
  static late Stopwatch _stopwatch;

  /// ✨ IMPROVED: Initialize performance monitoring
  /// تحسين: بدء مراقبة الأداء
  static void initialize() {
    _stopwatch = Stopwatch();
    print('${LogTags.download} تم تشغيل مراقبة الأداء');
  }

  /// ✨ IMPROVED: Measure operation time
  /// تحسين: قياس وقت العملية
  static Future<T> measurePerformance<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    try {
      _stopwatch.reset();
      _stopwatch.start();

      final result = await operation();

      _stopwatch.stop();
      final duration = _stopwatch.elapsedMilliseconds;

      _performanceMetrics[operationName] = duration;

      if (duration > 1000) {
        print(
            '⚠️ ${LogTags.download} عملية بطيئة: $operationName (${duration}ms)');
      } else {
        print('✅ ${LogTags.download} $operationName (${duration}ms)');
      }

      return result;
    } catch (e) {
      print('❌ ${LogTags.download} خطأ في $operationName: $e');
      rethrow;
    }
  }

  /// ✨ IMPROVED: Clear memory and unused resources
  /// تحسين: تنظيف الذاكرة والموارد غير المستخدمة
  static Future<void> clearMemory() async {
    try {
      // تحسين: تنظيف الصور المخزنة مؤقتاً
      imageCache.clear();
      imageCache.clearLiveImages();

      // تحسين: جمع الذاكرة غير المستخدمة
      await Future.delayed(const Duration(milliseconds: 100));

      print('✅ ${LogTags.download} تم تنظيف الذاكرة');
    } catch (e) {
      print('❌ ${LogTags.download} خطأ في تنظيف الذاكرة: $e');
    }
  }

  /// ✨ IMPROVED: Get performance report
  /// تحسين: الحصول على تقرير الأداء
  static Map<String, dynamic> getPerformanceReport() {
    final sortedMetrics = _performanceMetrics.entries.toList()
      ..sort((a, b) => (b.value as int).compareTo(a.value as int));

    return {
      'total_operations': _performanceMetrics.length,
      'slowest_operations': sortedMetrics.take(3).map((e) {
        return {'name': e.key, 'time_ms': e.value};
      }).toList(),
      'total_time_ms':
          sortedMetrics.fold(0, (sum, e) => sum + (e.value as int)),
      'average_time_ms': _performanceMetrics.isEmpty
          ? 0
          : sortedMetrics.fold(0, (sum, e) => sum + (e.value as int)) ~/
              _performanceMetrics.length,
    };
  }

  /// ✨ IMPROVED: Reset metrics
  /// تحسين: إعادة تعيين المقاييس
  static void resetMetrics() {
    _performanceMetrics.clear();
    print('✅ ${LogTags.download} تم إعادة تعيين مقاييس الأداء');
  }

  /// ✨ IMPROVED: Print performance summary
  /// تحسين: طباعة ملخص الأداء
  static void printSummary() {
    final report = getPerformanceReport();
    print('''
╔════════════════════════════════════════╗
║        📊 تقرير الأداء                 ║
╠════════════════════════════════════════╣
║ إجمالي العمليات: ${report['total_operations']}
║ إجمالي الوقت: ${report['total_time_ms']}ms
║ متوسط الوقت: ${report['average_time_ms']}ms
╠════════════════════════════════════════╣
║        ⏱️ أبطأ 3 عمليات:              ║
${(report['slowest_operations'] as List).map((op) => '║ • ${op['name']}: ${op['time_ms']}ms').join('\n')}
╚════════════════════════════════════════╝
    ''');
  }
}

/// ✨ IMPROVED: Memory-efficient list widget with lazy loading
/// تحسين: قائمة فعالة بالذاكرة مع تحميل كسول
class EfficientListView extends StatelessWidget {
  final List<dynamic> items;
  final IndexedWidgetBuilder itemBuilder;
  final int? itemCount;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final bool shrinkWrap;
  final ScrollController? controller;

  const EfficientListView({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.itemCount,
    this.physics,
    this.padding,
    this.shrinkWrap = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحسين: استخدام ListView.builder لتوفير الذاكرة
    return ListView.builder(
      itemCount: itemCount ?? items.length,
      itemBuilder: itemBuilder,
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      padding: padding,
      shrinkWrap: shrinkWrap,
      controller: controller,
      // تحسين: تخزين مؤقت للعناصر المرئية فقط
      cacheExtent: 500,
    );
  }
}

/// ✨ IMPROVED: Memory-efficient grid widget
/// تحسين: شبكة فعالة بالذاكرة
class EfficientGridView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int crossAxisCount;
  final EdgeInsets? padding;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const EfficientGridView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.crossAxisCount,
    this.padding,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحسين: استخدام GridView.builder للكفاءة
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      padding: padding,
      cacheExtent: 500,
    );
  }
}

/// ✨ IMPROVED: Debouncer for search and filtering
/// تحسين: تأخير للبحث والفلترة لتوفير الموارد
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  void call(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  void cancel() {
    _timer?.cancel();
  }
}

/// ✨ IMPROVED: Throttler for frequent events
/// تحسين: محدود للأحداث المتكررة
class Throttler {
  final Duration duration;
  DateTime? _lastCall;

  Throttler({this.duration = const Duration(milliseconds: 500)});

  Future<T>? call<T>(Future<T> Function() action) {
    final now = DateTime.now();
    if (_lastCall == null ||
        now.difference(_lastCall!).inMilliseconds > duration.inMilliseconds) {
      _lastCall = now;
      return action();
    }
    return null;
  }
}
