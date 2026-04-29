import 'package:flutter/material.dart';
import '../theme/premium_theme.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String? filePath;
  
  const AudioPlayerScreen({Key? key, this.filePath}) : super(key: key);

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PremiumColors.bg0,
      appBar: AppBar(
        backgroundColor: PremiumColors.bg0,
        elevation: 0,
        title: Text(
          'Audio Player',
          style: PremiumTypography.headingSmall.copyWith(
            color: PremiumColors.textPrimary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: PremiumColors.gradientAccent,
              ),
              child: const Icon(
                Icons.music_note_rounded,
                color: Colors.white,
                size: 100,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Audio Track',
              style: PremiumTypography.headingMedium.copyWith(
                color: PremiumColors.textPrimary,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous_rounded),
                  color: PremiumColors.accentPrimary,
                  iconSize: 32,
                  onPressed: () {},
                ),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: PremiumColors.gradientAccent,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => setState(() => _isPlaying = !_isPlaying),
                      borderRadius: BorderRadius.circular(32),
                      child: Center(
                        child: Icon(
                          _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next_rounded),
                  color: PremiumColors.accentPrimary,
                  iconSize: 32,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
