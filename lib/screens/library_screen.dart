import 'package:flutter/material.dart';
import '../theme/premium_theme.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['All', 'Videos', 'Audio', 'Playlists'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PremiumColors.bg0,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            elevation: 0,
            backgroundColor: PremiumColors.bg0,
            flexibleSpace: FlexibleSpaceBar(
              title: Transform.translate(
                offset: const Offset(0, 8),
                child: Text(
                  'Library',
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
                      PremiumColors.accentMagenta.withOpacity(0.15),
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
                const SizedBox(height: 12),
                _buildTabBar(),
                const SizedBox(height: 16),
                _buildLibraryContent(),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          _tabs.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _selectedTab == index
                      ? PremiumColors.accentPrimary
                      : PremiumColors.bg1,
                  border: Border.all(
                    color: _selectedTab == index
                        ? PremiumColors.accentPrimary
                        : PremiumColors.accentPrimary.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  _tabs[index],
                  style: PremiumTypography.bodySmall.copyWith(
                    color: _selectedTab == index
                        ? Colors.white
                        : PremiumColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLibraryContent() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return _buildLibraryItem(index);
      },
    );
  }

  Widget _buildLibraryItem(int index) {
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
              color: index % 2 == 0
                  ? PremiumColors.accentPrimary.withOpacity(0.2)
                  : PremiumColors.accentMagenta.withOpacity(0.2),
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
                                  PremiumColors.accentMagenta,
                                ],
                              ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        index % 3 == 0
                            ? Icons.music_note_rounded
                            : index % 3 == 1
                                ? Icons.video_library_rounded
                                : Icons.playlist_play_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Item ${index + 1}',
                      style: PremiumTypography.bodyLarge.copyWith(
                        color: PremiumColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${(index + 1) * 2} items',
                      style: PremiumTypography.bodySmall.copyWith(
                        color: PremiumColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: PremiumColors.accentPrimary.withOpacity(0.2),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.more_vert_rounded,
                      color: PremiumColors.accentPrimary,
                      size: 18,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
