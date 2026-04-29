/// Error handling utilities for Eclipse Player
/// 
/// Provides standardized error types and handling across all services.

import 'package:flutter/material.dart';

/// Base error class for all application errors
class AppError implements Exception {
  final String message;
  final String code;
  final StackTrace? stackTrace;
  final dynamic originalError;

  AppError({
    required this.message,
    required this.code,
    this.stackTrace,
    this.originalError,
  });

  @override
  String toString() => 'AppError($code): $message';
}

/// Download-specific errors
class DownloadException extends AppError {
  DownloadException({
    required String message,
    required String code,
    StackTrace? stackTrace,
    dynamic originalError,
  }) : super(
    message: message,
    code: code,
    stackTrace: stackTrace,
    originalError: originalError,
  );

  factory DownloadException.networkError(dynamic error, [StackTrace? st]) =>
    DownloadException(
      message: 'Network error during download',
      code: 'DOWNLOAD_NETWORK_ERROR',
      stackTrace: st,
      originalError: error,
    );

  factory DownloadException.diskFull(dynamic error, [StackTrace? st]) =>
    DownloadException(
      message: 'Insufficient disk space',
      code: 'DOWNLOAD_DISK_FULL',
      stackTrace: st,
      originalError: error,
    );

  factory DownloadException.permissionDenied(dynamic error, [StackTrace? st]) =>
    DownloadException(
      message: 'Permission denied for download operation',
      code: 'DOWNLOAD_PERMISSION_DENIED',
      stackTrace: st,
      originalError: error,
    );

  factory DownloadException.timeout(dynamic error, [StackTrace? st]) =>
    DownloadException(
      message: 'Download timeout - connection lost',
      code: 'DOWNLOAD_TIMEOUT',
      stackTrace: st,
      originalError: error,
    );

  factory DownloadException.invalidUrl(dynamic error, [StackTrace? st]) =>
    DownloadException(
      message: 'Invalid URL provided',
      code: 'DOWNLOAD_INVALID_URL',
      stackTrace: st,
      originalError: error,
    );
}

/// Playback-specific errors
class PlaybackException extends AppError {
  PlaybackException({
    required String message,
    required String code,
    StackTrace? stackTrace,
    dynamic originalError,
  }) : super(
    message: message,
    code: code,
    stackTrace: stackTrace,
    originalError: originalError,
  );

  factory PlaybackException.fileNotFound(dynamic error, [StackTrace? st]) =>
    PlaybackException(
      message: 'Media file not found',
      code: 'PLAYBACK_FILE_NOT_FOUND',
      stackTrace: st,
      originalError: error,
    );

  factory PlaybackException.unsupportedFormat(dynamic error, [StackTrace? st]) =>
    PlaybackException(
      message: 'Unsupported media format',
      code: 'PLAYBACK_UNSUPPORTED_FORMAT',
      stackTrace: st,
      originalError: error,
    );

  factory PlaybackException.corruptedFile(dynamic error, [StackTrace? st]) =>
    PlaybackException(
      message: 'Media file is corrupted',
      code: 'PLAYBACK_CORRUPTED_FILE',
      stackTrace: st,
      originalError: error,
    );

  factory PlaybackException.deviceError(dynamic error, [StackTrace? st]) =>
    PlaybackException(
      message: 'Audio device error',
      code: 'PLAYBACK_DEVICE_ERROR',
      stackTrace: st,
      originalError: error,
    );
}

/// Storage-specific errors
class StorageException extends AppError {
  StorageException({
    required String message,
    required String code,
    StackTrace? stackTrace,
    dynamic originalError,
  }) : super(
    message: message,
    code: code,
    stackTrace: stackTrace,
    originalError: originalError,
  );

  factory StorageException.readFailed(dynamic error, [StackTrace? st]) =>
    StorageException(
      message: 'Failed to read from storage',
      code: 'STORAGE_READ_FAILED',
      stackTrace: st,
      originalError: error,
    );

  factory StorageException.writeFailed(dynamic error, [StackTrace? st]) =>
    StorageException(
      message: 'Failed to write to storage',
      code: 'STORAGE_WRITE_FAILED',
      stackTrace: st,
      originalError: error,
    );

  factory StorageException.insufficientSpace(dynamic error, [StackTrace? st]) =>
    StorageException(
      message: 'Insufficient storage space',
      code: 'STORAGE_INSUFFICIENT_SPACE',
      stackTrace: st,
      originalError: error,
    );

  factory StorageException.permissionDenied(dynamic error, [StackTrace? st]) =>
    StorageException(
      message: 'Storage permission denied',
      code: 'STORAGE_PERMISSION_DENIED',
      stackTrace: st,
      originalError: error,
    );
}

/// Database-specific errors
class DatabaseException extends AppError {
  DatabaseException({
    required String message,
    required String code,
    StackTrace? stackTrace,
    dynamic originalError,
  }) : super(
    message: message,
    code: code,
    stackTrace: stackTrace,
    originalError: originalError,
  );

  factory DatabaseException.queryFailed(dynamic error, [StackTrace? st]) =>
    DatabaseException(
      message: 'Database query failed',
      code: 'DATABASE_QUERY_FAILED',
      stackTrace: st,
      originalError: error,
    );

  factory DatabaseException.insertFailed(dynamic error, [StackTrace? st]) =>
    DatabaseException(
      message: 'Failed to insert data',
      code: 'DATABASE_INSERT_FAILED',
      stackTrace: st,
      originalError: error,
    );

  factory DatabaseException.updateFailed(dynamic error, [StackTrace? st]) =>
    DatabaseException(
      message: 'Failed to update data',
      code: 'DATABASE_UPDATE_FAILED',
      stackTrace: st,
      originalError: error,
    );

  factory DatabaseException.deleteFailed(dynamic error, [StackTrace? st]) =>
    DatabaseException(
      message: 'Failed to delete data',
      code: 'DATABASE_DELETE_FAILED',
      stackTrace: st,
      originalError: error,
    );
}

/// Error handler with logging and user feedback
class ErrorHandler {
  /// Handle error and return user-friendly message
  static String getUserMessage(AppError error) {
    switch (error.code) {
      case 'DOWNLOAD_DISK_FULL':
        return 'Not enough storage space. Please free up some space.';
      case 'DOWNLOAD_NETWORK_ERROR':
        return 'Network error. Check your connection and try again.';
      case 'DOWNLOAD_TIMEOUT':
        return 'Download took too long. Please try again.';
      case 'DOWNLOAD_PERMISSION_DENIED':
        return 'Permission denied. Check app permissions in settings.';
      case 'PLAYBACK_FILE_NOT_FOUND':
        return 'Media file not found. It may have been deleted.';
      case 'PLAYBACK_UNSUPPORTED_FORMAT':
        return 'This media format is not supported.';
      case 'PLAYBACK_DEVICE_ERROR':
        return 'Audio device error. Try restarting the app.';
      case 'STORAGE_INSUFFICIENT_SPACE':
        return 'Insufficient storage space available.';
      case 'STORAGE_PERMISSION_DENIED':
        return 'Storage permission not granted.';
      case 'DATABASE_QUERY_FAILED':
        return 'Failed to fetch data. Try again later.';
      default:
        return error.message;
    }
  }

  /// Log error for debugging
  static void logError(AppError error) {
    debugPrint('═════════════════════════════════════');
    debugPrint('❌ ERROR: ${error.code}');
    debugPrint('Message: ${error.message}');
    if (error.originalError != null) {
      debugPrint('Original: ${error.originalError}');
    }
    if (error.stackTrace != null) {
      debugPrint('Stack Trace:\n${error.stackTrace}');
    }
    debugPrint('═════════════════════════════════════');
  }

  /// Show error snackbar to user
  static void showErrorSnackbar(
    BuildContext context,
    AppError error, {
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(getUserMessage(error)),
        duration: duration,
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show error dialog
  static Future<void> showErrorDialog(
    BuildContext context,
    AppError error, {
    String? title,
  }) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? 'Error'),
        content: Text(getUserMessage(error)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

/// Extension for safe error handling
extension SafeErrorHandling<T> on Future<T> {
  /// Wrap future with error handling
  Future<T?> handleError({
    required BuildContext context,
    bool showDialog = false,
  }) async {
    try {
      return await this;
    } on AppError catch (e) {
      ErrorHandler.logError(e);
      if (showDialog) {
        if (context.mounted) {
          await ErrorHandler.showErrorDialog(context, e);
        }
      } else {
        if (context.mounted) {
          ErrorHandler.showErrorSnackbar(context, e);
        }
      }
      return null;
    } catch (e, st) {
      final error = AppError(
        message: e.toString(),
        code: 'UNKNOWN_ERROR',
        stackTrace: st,
        originalError: e,
      );
      ErrorHandler.logError(error);
      if (context.mounted) {
        ErrorHandler.showErrorSnackbar(context, error);
      }
      return null;
    }
  }
}
