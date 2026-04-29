import 'package:flutter/material.dart';
import '../theme/premium_theme.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PremiumColors.bg0,
      appBar: AppBar(
        backgroundColor: PremiumColors.bg0,
        elevation: 0,
        title: Text(
          'Playlists',
          style: PremiumTypography.headingSmall.copyWith(
            color: PremiumColors.textPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildPlaylistItem(index),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PremiumColors.accentPrimary,
        onPressed: () {},
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _buildPlaylistItem(int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: PremiumColors.bg1,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: PremiumColors.accentPrimary.withOpacity(0.1),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      PremiumColors.accentPrimary.withOpacity(0.3),
                      PremiumColors.accentCyan.withOpacity(0.3),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.playlist_play_rounded,
                  color: Colors.white54,
                  size: 40,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Playlist ${index + 1}',
                      style: PremiumTypography.bodyLarge.copyWith(
                        color: PremiumColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${(index + 1) * 5} items',
                      style: PremiumTypography.bodySmall.copyWith(
                        color: PremiumColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert_rounded),
                color: PremiumColors.textSecondary,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
