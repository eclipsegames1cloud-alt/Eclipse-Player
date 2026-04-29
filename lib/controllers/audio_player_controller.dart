import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/extended_models.dart';

class AudioPlayerController extends GetxController {
  late AudioPlayer audioPlayer;
  
  // Observables
  final currentMediaItem = Rxn<MediaItem>();
  final isPlaying = false.obs;
  final currentPosition = const Duration().obs;
  final duration = const Duration().obs;
  final playbackSpeed = 1.0.obs;
  final isMuted = false.obs;
  final volume = 1.0.obs;
  final repeatMode = RepeatMode.off.obs;
  final isShuffle = false.obs;
  final playlist = RxList<MediaItem>();
  final currentIndex = (-1).obs;
  
  // UI State
  final isFullScreenPlayer = false.obs;
  final showPlaylistPanel = false.obs;
  final selectedAudioImage = Rxn<String>();
  
  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
    _setupAudioPlayer();
    _loadPlaylist();
  }
  
  void _setupAudioPlayer() {
    // Listen to player state changes
    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });
    
    // Listen to position changes
    audioPlayer.onPositionChanged.listen((position) {
      currentPosition.value = position;
    });
    
    // Listen to duration changes
    audioPlayer.onDurationChanged.listen((d) {
      duration.value = d;
    });
    
    // Listen to player completion
    audioPlayer.onPlayerComplete.listen((event) {
      _handlePlaybackCompletion();
    });
  }
  
  Future<void> playAudio(MediaItem mediaItem) async {
    currentMediaItem.value = mediaItem;
    try {
      await audioPlayer.play(UrlAudioSource(mediaItem.url));
    } catch (e) {
      Get.snackbar('خطأ', 'لا يمكن تشغيل الملف: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
  
  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }
  
  Future<void> resumeAudio() async {
    await audioPlayer.resume();
  }
  
  Future<void> togglePlayPause() async {
    if (isPlaying.value) {
      await pauseAudio();
    } else {
      await resumeAudio();
    }
  }
  
  Future<void> seekTo(Duration position) async {
    await audioPlayer.seek(position);
  }
  
  Future<void> setPlaybackSpeed(double speed) async {
    playbackSpeed.value = speed;
    await audioPlayer.setPlaybackRate(speed);
  }
  
  Future<void> setVolume(double vol) async {
    volume.value = vol;
    await audioPlayer.setVolume(vol);
  }
  
  Future<void> toggleMute() async {
    isMuted.value = !isMuted.value;
    await audioPlayer.setVolume(isMuted.value ? 0 : volume.value);
  }
  
  void setRepeatMode(RepeatMode mode) {
    repeatMode.value = mode;
  }
  
  void toggleShuffle() {
    isShuffle.value = !isShuffle.value;
  }
  
  void playNext() {
    if (playlist.isEmpty) return;
    int nextIndex = currentIndex.value + 1;
    if (nextIndex >= playlist.length) {
      nextIndex = 0;
    }
    _playAt(nextIndex);
  }
  
  void playPrevious() {
    if (playlist.isEmpty) return;
    int prevIndex = currentIndex.value - 1;
    if (prevIndex < 0) {
      prevIndex = playlist.length - 1;
    }
    _playAt(prevIndex);
  }
  
  void _playAt(int index) {
    if (index < 0 || index >= playlist.length) return;
    currentIndex.value = index;
    playAudio(playlist[index]);
  }
  
  void _handlePlaybackCompletion() {
    if (repeatMode.value == RepeatMode.one) {
      playAudio(currentMediaItem.value!);
    } else {
      playNext();
    }
  }
  
  void _loadPlaylist() {
    // Load from database or preferences
    // This is a placeholder
    playlist.clear();
  }
  
  void setSelectedAudioImage(String imagePath) {
    selectedAudioImage.value = imagePath;
  }
  
  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}

enum RepeatMode { off, all, one }
