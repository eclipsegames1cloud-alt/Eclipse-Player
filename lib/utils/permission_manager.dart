import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../utils/constants.dart';

class PermissionManager {
  /// Request all necessary permissions
  static Future<Map<Permission, PermissionStatus>> requestAllPermissions() async {
    if (Platform.isAndroid) {
      return _requestAndroidPermissions();
    } else if (Platform.isIOS) {
      return _requestIOSPermissions();
    }
    return {};
  }
  
  /// Android-specific permissions
  static Future<Map<Permission, PermissionStatus>> _requestAndroidPermissions() async {
    final List<Permission> permissions = [
      Permission.internet,
      Permission.storage,
      Permission.manageExternalStorage,
      Permission.photos,
      Permission.videos,
      Permission.audio,
      Permission.notification,
      Permission.recordAudio,
    ];
    
    // Add media-specific permissions for Android 13+
    if (Platform.isAndroid) {
      permissions.addAll([
        Permission.mediaLibrary,
      ]);
    }
    
    return await permissions.request();
  }
  
  /// iOS-specific permissions
  static Future<Map<Permission, PermissionStatus>> _requestIOSPermissions() async {
    final List<Permission> permissions = [
      Permission.photos,
      Permission.mediaLibrary,
      Permission.audio,
      Permission.recordAudio,
    ];
    
    return await permissions.request();
  }
  
  /// Check if storage permission is granted
  static Future<bool> hasStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.manageExternalStorage.status;
      return status.isGranted;
    } else if (Platform.isIOS) {
      final status = await Permission.photos.status;
      return status.isGranted;
    }
    return true;
  }
  
  /// Check if audio permission is granted
  static Future<bool> hasAudioPermission() async {
    final status = await Permission.audio.status;
    return status.isGranted;
  }
  
  /// Check if notification permission is granted
  static Future<bool> hasNotificationPermission() async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }
  
  /// Check if microphone permission is granted
  static Future<bool> hasMicrophonePermission() async {
    final status = await Permission.recordAudio.status;
    return status.isGranted;
  }
  
  /// Request storage permission only
  static Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.manageExternalStorage.request();
      return status.isGranted;
    } else if (Platform.isIOS) {
      final status = await Permission.photos.request();
      return status.isGranted;
    }
    return true;
  }
  
  /// Request audio permission only
  static Future<bool> requestAudioPermission() async {
    final status = await Permission.audio.request();
    return status.isGranted;
  }
  
  /// Request notification permission only
  static Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }
  
  /// Request microphone permission only
  static Future<bool> requestMicrophonePermission() async {
    final status = await Permission.recordAudio.request();
    return status.isGranted;
  }
  
  /// Check if permission is permanently denied
  static Future<bool> isPermanentlyDenied(Permission permission) async {
    final status = await permission.status;
    return status.isPermanentlyDenied;
  }
  
  /// Open app settings for permission management
  static Future<bool> openAppSettings() async {
    return await openAppSettings();
  }
  
  /// Get status string for UI display
  static String getStatusString(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return 'منح';
      case PermissionStatus.denied:
        return 'مرفوض';
      case PermissionStatus.restricted:
        return 'مقيد';
      case PermissionStatus.permanentlyDenied:
        return 'مرفوض نهائياً';
      case PermissionStatus.limited:
        return 'محدود';
      default:
        return 'غير معروف';
    }
  }
}

/// Permission Dialog Manager
class PermissionDialog {
  /// Show permission request dialog
  static Future<void> showPermissionDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String permissionName,
    required VoidCallback onAllow,
    required VoidCallback onDeny,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDeny();
            },
            child: const Text('رفض'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onAllow();
            },
            child: const Text('السماح'),
          ),
        ],
      ),
    );
  }
  
  /// Show permission denied dialog
  static Future<void> showPermissionDeniedDialog(
    BuildContext context, {
    required String permissionName,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إذن مرفوض'),
        content: Text('$permissionName مطلوب لاستخدام هذه الميزة'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              PermissionManager.openAppSettings();
            },
            child: const Text('فتح الإعدادات'),
          ),
        ],
      ),
    );
  }
  
  /// Show multiple permissions required dialog
  static Future<void> showMultiplePermissionsDialog(
    BuildContext context, {
    required List<String> permissions,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('أذونات مطلوبة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('يحتاج التطبيق للأذونات التالية:'),
            const SizedBox(height: 16),
            ...permissions.map((p) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(p),
                ],
              ),
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('الغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              PermissionManager.requestAllPermissions();
            },
            child: const Text('منح الأذونات'),
          ),
        ],
      ),
    );
  }
}
