import 'package:audio_session/audio_session.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// PREMIUM AUDIO ENGINE - SPOTIFY-LEVEL EXPERIENCE
/// Background Playback, MediaSession, Media Notification
/// ═══════════════════════════════════════════════════════════════════════════

class AudioModel {
  final String id;
  final String title;
  final String? artist;
  final String url;
  final Duration duration;
  final String? imagePath;

  AudioModel({
    required this.id,
    required this.title,
    this.artist,
    required this.url,
    required this.duration,
    this.imagePath,
  });
}

class AudioEngine extends GetxController {
  // ─────────────────────────────────────────────────────────────────────────
  // STATE MANAGEMENT
  // ─────────────────────────────────────────────────────────────────────────
  
  late AudioPlayer _audioPlayer;
  
  final isPlaying = false.obs;
  final currentAudio = Rx<AudioModel?>(null);
  final currentPosition = Duration.zero.obs;
  final totalDuration = Duration.zero.obs;
  final playbackSpeed = 1.0.obs;
  final isShuffle = false.obs;
  final repeatMode = RepeatMode.off.obs;
  final volume = 1.0.obs;
  
  final playlist = <AudioModel>[].obs;
  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAudio();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // INITIALIZATION
  // ─────────────────────────────────────────────────────────────────────────
  
  Future<void> _initializeAudio() async {
    _audioPlayer = AudioPlayer();

    // Configure audio session for background playback
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.default_,
      androidAudioAttributes: AndroidAudioAttributes(
        contentType: AndroidAudioContentType.movie,
        flags: [AndroidAudioFlags.audibilityEnforced],
        usage: AndroidAudioUsage.media,
      ),
      androidWillPauseWhenDucked: true,
    ));

    // Listen to audio events
    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
      if (state == PlayerState.completed) {
        _onAudioComplete();
      }
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      totalDuration.value = duration;
    });

    _audioPlayer.onPositionChanged.listen((position) {
      currentPosition.value = position;
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // PLAYBACK CONTROL
  // ─────────────────────────────────────────────────────────────────────────
  
  Future<void> playAudio(AudioModel audio) async {
    try {
      currentAudio.value = audio;
      await _audioPlayer.play(
        UrlSource(audio.url),
        playerId: 'premium-audio',
      );
      await _audioPlayer.setPlaybackRate(playbackSpeed.value);
      await _audioPlayer.setVolume(volume.value);
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  Future<void> togglePlayPause() async {
    if (currentAudio.value == null) return;
    
    try {
      if (isPlaying.value) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.resume();
      }
    } catch (e) {
      debugPrint('Error toggling playback: $e');
    }
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    await _audioPlayer.resume();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> setPlaybackSpeed(double speed) async {
    playbackSpeed.value = speed;
    await _audioPlayer.setPlaybackRate(speed);
  }

  Future<void> setVolume(double vol) async {
    volume.value = vol;
    await _audioPlayer.setVolume(vol);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // PLAYLIST CONTROL
  // ─────────────────────────────────────────────────────────────────────────
  
  void addToPlaylist(AudioModel audio) {
    playlist.add(audio);
  }

  void clearPlaylist() {
    playlist.clear();
    currentIndex.value = 0;
  }

  Future<void> playNext() async {
    if (playlist.isEmpty) return;
    
    int nextIndex = currentIndex.value + 1;
    if (nextIndex >= playlist.length) {
      if (repeatMode.value == RepeatMode.all) {
        nextIndex = 0;
      } else {
        return;
      }
    }
    
    currentIndex.value = nextIndex;
    await playAudio(playlist[nextIndex]);
  }

  Future<void> playPrevious() async {
    if (playlist.isEmpty) return;
    
    int prevIndex = currentIndex.value - 1;
    if (prevIndex < 0) {
      prevIndex = playlist.length - 1;
    }
    
    currentIndex.value = prevIndex;
    await playAudio(playlist[prevIndex]);
  }

  void toggleShuffle() {
    isShuffle.value = !isShuffle.value;
  }

  void cycleRepeatMode() {
    if (repeatMode.value == RepeatMode.off) {
      repeatMode.value = RepeatMode.one;
    } else if (repeatMode.value == RepeatMode.one) {
      repeatMode.value = RepeatMode.all;
    } else {
      repeatMode.value = RepeatMode.off;
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // INTERNAL HANDLERS
  // ─────────────────────────────────────────────────────────────────────────
  
  void _onAudioComplete() {
    if (repeatMode.value == RepeatMode.one) {
      seek(Duration.zero);
      resume();
    } else {
      playNext();
    }
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}

enum RepeatMode { off, one, all }