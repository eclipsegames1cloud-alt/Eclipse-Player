import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../models/extended_models.dart';
import '../utils/extensions.dart';

class VideoPlayerController extends GetxController {
  late VideoPlayerController _videoController;
  
  // Observables
  final isPlaying = false.obs;
  final currentPosition = const Duration().obs;
  final duration = const Duration().obs;
  final isFullScreen = false.obs;
  final isBuffering = false.obs;
  final showControls = true.obs;
  final playbackSpeed = 1.0.obs;
  final volume = 1.0.obs;
  final isMuted = false.obs;
  final currentMediaItem = Rxn<MediaItem>();
  
  // Gesture state
  final brightnessLevel = 0.5.obs; // 0.0 to 1.0
  final lastGestureType = ''.obs; // 'seek', 'volume', 'brightness'
  
  @override
  void onInit() {
    super.onInit();
    _setupVideoController();
  }
  
  void _setupVideoController() {
    // Will be initialized when video is selected
  }
  
  /// Initialize with media item
  Future<void> initializeWithMedia(MediaItem mediaItem) async {
    currentMediaItem.value = mediaItem;
    
    try {
      isBuffering.value = true;
      
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(mediaItem.url),
      );
      
      await _videoController.initialize();
      
      _setupVideoControllerListeners();
      
      isBuffering.value = false;
    } catch (e) {
      print('Failed to initialize video: $e');
      isBuffering.value = false;
    }
  }
  
  void _setupVideoControllerListeners() {
    _videoController.addListener(() {
      if (_videoController.value.isInitialized) {
        currentPosition.value = _videoController.value.position;
        duration.value = _videoController.value.duration;
        
        if (_videoController.value.isBuffering) {
          isBuffering.value = true;
        } else {
          isBuffering.value = false;
        }
      }
    });
  }
  
  /// Play video
  Future<void> play() async {
    await _videoController.play();
    isPlaying.value = true;
  }
  
  /// Pause video
  Future<void> pause() async {
    await _videoController.pause();
    isPlaying.value = false;
  }
  
  /// Toggle play/pause
  Future<void> togglePlayPause() async {
    if (isPlaying.value) {
      await pause();
    } else {
      await play();
    }
  }
  
  /// Seek to position
  Future<void> seekTo(Duration position) async {
    await _videoController.seekTo(position);
  }
  
  /// Set playback speed
  Future<void> setPlaybackSpeed(double speed) async {
    playbackSpeed.value = speed;
    await _videoController.setPlaybackSpeed(speed);
  }
  
  /// Set volume
  Future<void> setVolume(double vol) async {
    volume.value = vol.clamp(0.0, 1.0);
    await _videoController.setVolume(volume.value);
  }
  
  /// Toggle mute
  Future<void> toggleMute() async {
    isMuted.value = !isMuted.value;
    await _videoController.setVolume(isMuted.value ? 0 : volume.value);
  }
  
  /// Toggle fullscreen
  void toggleFullScreen() {
    isFullScreen.value = !isFullScreen.value;
  }
  
  /// Handle horizontal swipe (seek)
  void handleHorizontalSwipe(double deltaX) {
    lastGestureType.value = 'seek';
    
    const double seekDeltaMs = 500; // 500ms per swipe unit
    final seekDelta = Duration(
      milliseconds: (deltaX * seekDeltaMs).toInt(),
    );
    
    final newPosition = currentPosition.value + seekDelta;
    final clampedPosition = Duration(
      milliseconds: newPosition.inMilliseconds.clamp(
        0,
        duration.value.inMilliseconds,
      ),
    );
    
    seekTo(clampedPosition);
  }
  
  /// Handle vertical swipe on left side (brightness)
  void handleVerticalSwipeLeft(double deltaY) {
    lastGestureType.value = 'brightness';
    
    const double sensitivityFactor = 0.5;
    final newBrightness = (brightnessLevel.value - (deltaY * sensitivityFactor / 100))
        .clamp(0.0, 1.0);
    
    brightnessLevel.value = newBrightness;
  }
  
  /// Handle vertical swipe on right side (volume)
  void handleVerticalSwipeRight(double deltaY) {
    lastGestureType.value = 'volume';
    
    const double sensitivityFactor = 0.5;
    final newVolume = (volume.value - (deltaY * sensitivityFactor / 100))
        .clamp(0.0, 1.0);
    
    setVolume(newVolume);
  }
  
  /// Get video controller
  VideoPlayerController? getVideoController() {
    try {
      if (_videoController.value.isInitialized) {
        return _videoController;
      }
    } catch (e) {
      print('Error getting video controller: $e');
    }
    return null;
  }
  
  /// Get video value
  VideoPlayerValue? get videoValue {
    try {
      return _videoController.value;
    } catch (e) {
      return null;
    }
  }
  
  /// Check if initialized
  bool get isInitialized {
    try {
      return _videoController.value.isInitialized;
    } catch (e) {
      return false;
    }
  }
  
  /// Get progress percentage
  double getProgressPercentage() {
    if (duration.value.inMilliseconds == 0) return 0;
    return (currentPosition.value.inMilliseconds / 
            duration.value.inMilliseconds)
        .clamp(0.0, 1.0);
  }
  
  @override
  void onClose() {
    try {
      _videoController.dispose();
    } catch (e) {
      print('Error disposing video controller: $e');
    }
    super.onClose();
  }
}
