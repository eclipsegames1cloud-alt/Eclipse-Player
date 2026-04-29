import 'package:flutter/material.dart';
import 'constants.dart';

/// String Extensions
extension StringExtensions on String {
  /// Check if string is a valid YouTube URL
  bool get isYoutubeUrl => RegexPatterns.youtubeUrl.hasMatch(this);
  
  /// Check if string is a valid URL
  bool get isValidUrl => RegexPatterns.url.hasMatch(this);
  
  /// Check if string is a valid email
  bool get isValidEmail => RegexPatterns.email.hasMatch(this);
  
  /// Capitalize first letter
  String get capitalize => isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
  
  /// Check if string is a valid filename
  bool get isValidFilename => RegexPatterns.filename.hasMatch(this);
  
  /// Truncate string with ellipsis
  String truncate({int length = 50}) {
    return this.length > length ? '${substring(0, length)}...' : this;
  }
  
  /// Remove special characters
  String get removeSpecialChars {
    return replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
  }
  
  /// Get file extension
  String get fileExtension {
    if (!contains('.')) return '';
    return substring(lastIndexOf('.') + 1).toLowerCase();
  }
}

/// Duration Extensions
extension DurationExtensions on Duration {
  /// Format duration as HH:MM:SS
  String get formatted {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(inHours);
    final minutes = twoDigits(inMinutes.remainder(60));
    final seconds = twoDigits(inSeconds.remainder(60));
    
    return inHours > 0 
        ? '$hours:$minutes:$seconds' 
        : '$minutes:$seconds';
  }
  
  /// Format as readable string (e.g., "2h 30m")
  String get readableFormat {
    if (inHours > 0) {
      final mins = inMinutes.remainder(60);
      return '${inHours}h ${mins}m';
    }
    if (inMinutes > 0) {
      final secs = inSeconds.remainder(60);
      return '${inMinutes}m ${secs}s';
    }
    return '${inSeconds}s';
  }
}

/// Integer Extensions
extension IntExtensions on int {
  /// Format bytes to human readable size
  String get formatBytes {
    if (this < 1024) return '$this B';
    if (this < 1024 * 1024) return '${(this / 1024).toStringAsFixed(2)} KB';
    if (this < 1024 * 1024 * 1024) {
      return '${(this / 1024 / 1024).toStringAsFixed(2)} MB';
    }
    return '${(this / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
  }
  
  /// Convert to Duration
  Duration get duration => Duration(seconds: this);
}

/// Double Extensions
extension DoubleExtensions on double {
  /// Format bytes to human readable size
  String get formatBytes {
    final bytes = toInt();
    return bytes.formatBytes;
  }
  
  /// Round to specific decimal places
  double roundToDecimals(int decimals) {
    final factor = pow(10, decimals).toDouble();
    return (this * factor).round() / factor;
  }
}

/// BuildContext Extensions
extension BuildContextExtensions on BuildContext {
  /// Get screen width
  double get width => MediaQuery.of(this).size.width;
  
  /// Get screen height
  double get height => MediaQuery.of(this).size.height;
  
  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;
  
  /// Check if device is in landscape
  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;
  
  /// Check if device is in portrait
  bool get isPortrait => MediaQuery.of(this).orientation == Orientation.portrait;
  
  /// Check if device is tablet
  bool get isTablet => width > 600;
  
  /// Get device padding (for notch/safe area)
  EdgeInsets get devicePadding => MediaQuery.of(this).padding;
  
  /// Get device viewInsets (for keyboard)
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  
  /// Check if keyboard is visible
  bool get isKeyboardVisible => viewInsets.bottom > 0;
  
  /// Theme data
  ThemeData get theme => Theme.of(this);
  
  /// Text theme
  TextTheme get textTheme => theme.textTheme;
}

/// DateTime Extensions
extension DateTimeExtensions on DateTime {
  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
  
  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && 
           month == yesterday.month && 
           day == yesterday.day;
  }
  
  /// Format as readable date
  String get readableDate {
    if (isToday) return 'اليوم';
    if (isYesterday) return 'أمس';
    return '$day/$month/$year';
  }
  
  /// Format with time
  String get readableDateTime {
    final time = '$hour:${minute.toString().padLeft(2, '0')}';
    return '$readableDate - $time';
  }
  
  /// Time ago from now
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);
    
    if (difference.inSeconds < 60) return 'الآن';
    if (difference.inMinutes < 60) return 'منذ ${difference.inMinutes} دقائق';
    if (difference.inHours < 24) return 'منذ ${difference.inHours} ساعات';
    if (difference.inDays < 7) return 'منذ ${difference.inDays} أيام';
    
    return readableDate;
  }
}

/// List Extensions
extension ListExtensions<T> on List<T> {
  /// Get element at index safely
  T? getAt(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }
  
  /// Chunk list into smaller lists
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (int i = 0; i < length; i += size) {
      chunks.add(sublist(i, (i + size).clamp(0, length)));
    }
    return chunks;
  }
  
  /// Filter duplicates
  List<T> get unique {
    final seen = <T>{};
    return where((item) => seen.add(item)).toList();
  }
}

/// Map Extensions
extension MapExtensions<K, V> on Map<K, V> {
  /// Get value safely
  V? getSafe(K key) => containsKey(key) ? this[key] : null;
  
  /// Merge with another map
  Map<K, V> merge(Map<K, V> other) {
    return {...this, ...other};
  }
}

/// Widget Extensions
extension WidgetExtensions on Widget {
  /// Add padding around widget
  Padding padded({double all = 16}) => Padding(
    padding: EdgeInsets.all(all),
    child: this,
  );
  
  /// Add padding with custom values
  Padding paddedSymmetric({double horizontal = 16, double vertical = 0}) => Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
    child: this,
  );
  
  /// Wrap in Container with background
  Container withBackground(Color color) => Container(
    color: color,
    child: this,
  );
  
  /// Add border
  Container withBorder({Color color = Colors.grey, double width = 1}) => Container(
    decoration: BoxDecoration(
      border: Border.all(color: color, width: width),
    ),
    child: this,
  );
  
  /// Add shadow
  Container withShadow() => Container(
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: this,
  );
}

// Helper function for pow
double pow(num x, num y) {
  return x == 0 ? 0 : (y == 0 ? 1 : x * pow(x, y - 1));
}
