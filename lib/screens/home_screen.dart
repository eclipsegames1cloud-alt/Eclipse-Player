import 'package:flutter/material.dart';
import '../theme/premium_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AnimationController _animationController;
  bool _hasRecentlyPlayed = false;
  bool _hasLibraryItems = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PremiumColors.bg0,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            elevation: 0,
            backgroundColor: PremiumColors.bg0,
            flexibleSpace: FlexibleSpaceBar(
              title: Transform.translate(
                offset: const Offset(0, 8),
                child: Text(
                  'Eclipse Player',
                  style: PremiumTypography.headingLarge.copyWith(
                    color: PremiumColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      PremiumColors.accentPrimary.withOpacity(0.15),
                      PremiumColors.bg0.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                _buildQuickActions(),
                const SizedBox(height: 32),
                if (_hasRecentlyPlayed) ...[
                  _buildSectionHeader('Recently Played'),
                  const SizedBox(height: 12),
                  _buildRecentlyPlayedList(),
                  const SizedBox(height: 32),
                ] else
                  _buildEmptyRecentlyPlayed(),
                if (_hasLibraryItems) ...[
                  _buildSectionHeader('Your Library'),
                  const SizedBox(height: 12),
                  _buildLibraryGrid(),
                ] else
                  _buildEmptyLibrary(),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            icon: Icons.add_rounded,
            label: 'Add Media',
            onTap: () {},
            color: PremiumColors.accentPrimary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionCard(
            icon: Icons.open_in_browser_rounded,
            label: 'Browser',
            onTap: () {},
            color: PremiumColors.accentCyan,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionCard(
            icon: Icons.download_rounded,
            label: 'Download',
            onTap: () {},
            color: PremiumColors.accentMagenta,
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.15),
                color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: PremiumTypography.caption.copyWith(
                  color: PremiumColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: PremiumTypography.headingMedium.copyWith(
            color: PremiumColors.textPrimary,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'See all',
            style: PremiumTypography.bodySmall.copyWith(
              color: PremiumColors.accentPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentlyPlayedList() {
    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildMediaItem(
            title: 'Media Item ${index + 1}',
            subtitle: 'Artist or Duration',
            index: index,
          ),
        ),
      ),
    );
  }

  Widget _buildMediaItem({
    required String title,
    required String subtitle,
    required int index,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: PremiumColors.bg1,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: PremiumColors.accentPrimary.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: [
                      PremiumColors.accentPrimary.withOpacity(0.3),
                      PremiumColors.accentCyan.withOpacity(0.3),
                    ],
                  ),
                ),
                child: Icon(
                  index % 2 == 0 ? Icons.music_note_rounded : Icons.video_library_rounded,
                  color: Colors.white54,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: PremiumTypography.bodyLarge.copyWith(
                        color: PremiumColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: PremiumTypography.bodySmall.copyWith(
                        color: PremiumColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: PremiumColors.gradientAccent,
                  boxShadow: [
                    BoxShadow(
                      color: PremiumColors.accentPrimary.withOpacity(0.3),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {},
                    child: const Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLibraryGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildLibraryCard(index);
      },
    );
  }

  Widget _buildLibraryCard(int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                PremiumColors.bg1,
                PremiumColors.bg2,
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: PremiumColors.accentPrimary.withOpacity(0.15),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      index % 2 == 0
                          ? PremiumColors.accentPrimary.withOpacity(0.1)
                          : PremiumColors.accentCyan.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: index % 2 == 0
                            ? PremiumColors.gradientAccent
                            : LinearGradient(
                                colors: [
                                  PremiumColors.accentCyan,
                                  PremiumColors.accentPrimary,
                                ],
                              ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        index % 2 == 0
                            ? Icons.music_note_rounded
                            : Icons.video_library_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Playlist ${index + 1}',
                      style: PremiumTypography.bodyLarge.copyWith(
                        color: PremiumColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${index + 3} items',
                      style: PremiumTypography.bodySmall.copyWith(
                        color: PremiumColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyRecentlyPlayed() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: PremiumColors.gradientAccent,
                boxShadow: [
                  BoxShadow(
                    color: PremiumColors.accentPrimary.withOpacity(0.3),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: const Icon(
                Icons.history_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No Recently Played',
              style: PremiumTypography.headingSmall.copyWith(
                color: PremiumColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your recently played items will appear here',
              style: PremiumTypography.bodySmall.copyWith(
                color: PremiumColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyLibrary() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    PremiumColors.accentCyan,
                    PremiumColors.accentMagenta,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: PremiumColors.accentCyan.withOpacity(0.3),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: const Icon(
                Icons.library_music_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your Library is Empty',
              style: PremiumTypography.headingSmall.copyWith(
                color: PremiumColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add or download media to get started',
              style: PremiumTypography.bodySmall.copyWith(
                color: PremiumColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
