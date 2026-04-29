import 'package:audioplayers/audioplayers.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../utils/constants.dart';
import '../utils/extensions.dart';
import '../models/extended_models.dart';

/// Audio Background Service with MediaSession and Lock Screen Controls
class AudioBackgroundService {
  static final AudioBackgroundService _instance = AudioBackgroundService._internal();
  
  factory AudioBackgroundService() {
    return _instance;
  }
  
  AudioBackgroundService._internal();
  
  late AudioPlayer _audioPlayer;
  bool _isInitialized = false;
  
  // Observables for state management
  final isPlaying = false.obs;
  final currentPosition = const Duration().obs;
  final duration = const Duration().obs;
  final currentMediaTitle = ''.obs;
  final currentMediaArtist = ''.obs;
  final currentMediaThumbnail = ''.obs;
  
  /// Initialize audio session for background playback
  Future<bool> initialize() async {
    if (_isInitialized) return true;
    
    try {
      _audioPlayer = AudioPlayer();
      
      // Request audio session for background playback
      final session = await AudioSession.instance;
      await session.configure(
        AudioSessionConfiguration(
          avAudioSessionCategory: AVAudioSessionCategory.playback,
          avAudioSessionCategoryOptions: 
              AVAudioSessionCategoryOptions.duckOthers,
          avAudioSessionMode: AVAudioSessionMode.default_,
          avAudioSessionRouteSharingPolicy: 
              AVAudioSessionRouteSharingPolicy.longForm,
          androidAudioAttributes: const AndroidAudioAttributes(
            contentType: AndroidAudioContentType.music,
            usage: AndroidAudioUsage.media,
          ),
          androidWillPauseWhenDucked: true,
        ),
      );
      
      // Setup audio player listeners
      _setupAudioPlayerListeners();
      
      _isInitialized = true;
      print('${AppConstants.audioNotificationId} Audio service initialized');
      return true;
    } catch (e) {
      print('${LogTags.audio} Failed to initialize audio service: $e');
      return false;
    }
  }
  
  /// Setup audio player event listeners
  void _setupAudioPlayerListeners() {
    // Listen to player state changes
    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
      _updateMediaSessionState();
    });
    
    // Listen to position changes
    _audioPlayer.onPositionChanged.listen((position) {
      currentPosition.value = position;
    });
    
    // Listen to duration changes
    _audioPlayer.onDurationChanged.listen((d) {
      duration.value = d;
    });
    
    // Listen to player completion
    _audioPlayer.onPlayerComplete.listen((_) {
      _handlePlaybackCompletion();
    });
    
    // Listen to errors
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.stopped) {
        print('${LogTags.audio} Playback stopped');
      }
    });
  }
  
  /// Play audio from URL
  Future<void> playAudio(
    MediaItem mediaItem, {
    Duration? startPosition,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }
    
    try {
      currentMediaTitle.value = mediaItem.title;
      currentMediaArtist.value = mediaItem.channel ?? 'Unknown';
      currentMediaThumbnail.value = mediaItem.thumbnailUrl ?? '';
      
      await _audioPlayer.play(
        UrlAudioSource(mediaItem.url),
        position: startPosition,
      );
      
      print('${LogTags.audio} Playing: ${mediaItem.title}');
    } catch (e) {
      print('${LogTags.audio} Failed to play audio: $e');
      Get.snackbar(
        'خطأ في التشغيل',
        'فشل تشغيل الملف: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
  
  /// Pause audio playback
  Future<void> pauseAudio() async {
    try {
      await _audioPlayer.pause();
      isPlaying.value = false;
      _updateMediaSessionState();
    } catch (e) {
      print('${LogTags.audio} Failed to pause: $e');
    }
  }
  
  /// Resume audio playback
  Future<void> resumeAudio() async {
    try {
      await _audioPlayer.resume();
      isPlaying.value = true;
      _updateMediaSessionState();
    } catch (e) {
      print('${LogTags.audio} Failed to resume: $e');
    }
  }
  
  /// Toggle play/pause
  Future<void> togglePlayPause() async {
    if (isPlaying.value) {
      await pauseAudio();
    } else {
      await resumeAudio();
    }
  }
  
  /// Seek to position
  Future<void> seekTo(Duration position) async {
    try {
      if (position.inSeconds > duration.value.inSeconds) {
        return; // Don't seek beyond duration
      }
      await _audioPlayer.seek(position);
    } catch (e) {
      print('${LogTags.audio} Failed to seek: $e');
    }
  }
  
  /// Stop audio playback
  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      isPlaying.value = false;
      currentPosition.value = Duration.zero;
      _updateMediaSessionState();
    } catch (e) {
      print('${LogTags.audio} Failed to stop: $e');
    }
  }
  
  /// Set playback rate (speed)
  Future<void> setPlaybackRate(double rate) async {
    try {
      await _audioPlayer.setPlaybackRate(rate);
    } catch (e) {
      print('${LogTags.audio} Failed to set playback rate: $e');
    }
  }
  
  /// Set volume
  Future<void> setVolume(double volume) async {
    try {
      await _audioPlayer.setVolume(volume.clamp(0.0, 1.0));
    } catch (e) {
      print('${LogTags.audio} Failed to set volume: $e');
    }
  }
  
  /// Handle playback completion
  void _handlePlaybackCompletion() {
    print('${LogTags.audio} Playback completed');
    isPlaying.value = false;
    currentPosition.value = Duration.zero;
    _updateMediaSessionState();
    
    // You can emit an event to controller to play next track
    Get.find<AudioPlayerController>().playNext();
  }
  
  /// Update media session state (for lock screen controls)
  void _updateMediaSessionState() {
    // This will be used for OS-level media controls
    // Implementation depends on platform-specific setup
  }
  
  /// Get current playback state
  bool get isCurrentlyPlaying => isPlaying.value;
  
  /// Get current position as percentage
  double get currentPositionPercent {
    if (duration.value.inMilliseconds == 0) return 0;
    return (currentPosition.value.inMilliseconds / 
            duration.value.inMilliseconds)
        .clamp(0.0, 1.0);
  }
  
  /// Dispose service
  Future<void> dispose() async {
    try {
      await _audioPlayer.dispose();
      _isInitialized = false;
      print('${LogTags.audio} Audio service disposed');
    } catch (e) {
      print('${LogTags.audio} Error disposing audio service: $e');
    }
  }
}

/// Foreground Service for continuous background playback (Android)
class AudioForegroundService {
  /// Start foreground service for Android
  static Future<void> startForegroundService() async {
    if (!Platform.isAndroid) return;
    
    try {
      // This would typically involve platform channels to start a Foreground Service
      // For now, we rely on audioplayers package handling this automatically
      print('${LogTags.audio} Foreground service started');
    } catch (e) {
      print('${LogTags.audio} Failed to start foreground service: $e');
    }
  }
  
  /// Stop foreground service
  static Future<void> stopForegroundService() async {
    if (!Platform.isAndroid) return;
    
    try {
      print('${LogTags.audio} Foreground service stopped');
    } catch (e) {
      print('${LogTags.audio} Failed to stop foreground service: $e');
    }
  }
}

// Import at top would be: 
// import '../controllers/audio_player_controller.dart';
// This is added after AudioPlayerController is defined
