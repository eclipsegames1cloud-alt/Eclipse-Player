import 'package:flutter/material.dart';
import '../theme/premium_theme.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _isPlaying = false;
  double _currentPosition = 0.35;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PremiumColors.bg0,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  PremiumColors.accentPrimary.withOpacity(0.2),
                  PremiumColors.bg0,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                        color: PremiumColors.textPrimary,
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'Now Playing',
                        style: PremiumTypography.headingSmall.copyWith(
                          color: PremiumColors.textPrimary,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert_rounded),
                        color: PremiumColors.textPrimary,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 260,
                          height: 260,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: PremiumColors.gradientAccent,
                            boxShadow: [
                              BoxShadow(
                                color: PremiumColors.accentPrimary.withOpacity(0.4),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 120,
                          ),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          'Track Title',
                          style: PremiumTypography.headingMedium.copyWith(
                            color: PremiumColors.textPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Artist Name',
                          style: PremiumTypography.bodyLarge.copyWith(
                            color: PremiumColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: _currentPosition,
                          minHeight: 6,
                          backgroundColor: PremiumColors.bg2,
                          valueColor: AlwaysStoppedAnimation(
                            PremiumColors.accentPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${(_currentPosition * 240).toStringAsFixed(0)}s',
                            style: PremiumTypography.bodySmall.copyWith(
                              color: PremiumColors.textTertiary,
                            ),
                          ),
                          Text(
                            '4:00',
                            style: PremiumTypography.bodySmall.copyWith(
                              color: PremiumColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shuffle_rounded),
                            color: PremiumColors.textSecondary,
                            iconSize: 28,
                            onPressed: () {},
                          ),
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
                              boxShadow: [
                                BoxShadow(
                                  color: PremiumColors.accentPrimary.withOpacity(0.4),
                                  blurRadius: 16,
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => setState(() => _isPlaying = !_isPlaying),
                                borderRadius: BorderRadius.circular(32),
                                child: Center(
                                  child: Icon(
                                    _isPlaying
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 36,
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
                          IconButton(
                            icon: const Icon(Icons.repeat_rounded),
                            color: PremiumColors.textSecondary,
                            iconSize: 28,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
