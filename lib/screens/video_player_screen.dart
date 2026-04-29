import 'package:flutter/material.dart';
import '../theme/premium_theme.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String? filePath;
  
  const VideoPlayerScreen({Key? key, this.filePath}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isPlaying = false;
  bool _isFullscreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    PremiumColors.accentCyan.withOpacity(0.3),
                    PremiumColors.accentMagenta.withOpacity(0.3),
                  ],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.video_library_rounded,
                    color: Colors.white54,
                    size: 80,
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
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Video Title',
                      style: PremiumTypography.headingSmall.copyWith(
                        color: PremiumColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Channel Name • 1.2M views',
                      style: PremiumTypography.bodySmall.copyWith(
                        color: PremiumColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 0.35,
                        minHeight: 4,
                        backgroundColor: PremiumColors.bg2,
                        valueColor: AlwaysStoppedAnimation(
                          PremiumColors.accentCyan,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '2:24',
                          style: PremiumTypography.bodySmall.copyWith(
                            color: PremiumColors.textTertiary,
                          ),
                        ),
                        Text(
                          '6:50',
                          style: PremiumTypography.bodySmall.copyWith(
                            color: PremiumColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(Icons.thumb_up_rounded, 'Like'),
                        _buildActionButton(Icons.share_rounded, 'Share'),
                        _buildActionButton(Icons.download_rounded, 'Download'),
                        _buildActionButton(Icons.fullscreen_rounded, 'Fullscreen'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon),
          color: PremiumColors.accentCyan,
          onPressed: () {},
        ),
        Text(
          label,
          style: PremiumTypography.bodySmall.copyWith(
            color: PremiumColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
