import 'package:flutter/material.dart';
import '../theme/premium_theme.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({Key? key}) : super(key: key);

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['All', 'Completed', 'Downloading', 'Failed'];

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
                  'Downloads',
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
                      PremiumColors.accentCyan.withOpacity(0.15),
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
                _buildDownloadsList(),
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
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _selectedTab == index
                      ? PremiumColors.accentCyan
                      : PremiumColors.bg1,
                  border: Border.all(
                    color: _selectedTab == index
                        ? PremiumColors.accentCyan
                        : PremiumColors.accentCyan.withOpacity(0.3),
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

  Widget _buildDownloadsList() {
    return Column(
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildDownloadItem(index),
        ),
      ),
    );
  }

  Widget _buildDownloadItem(int index) {
    bool isCompleted = index < 2;
    bool isDownloading = index == 2;
    double progress = isDownloading ? 0.65 : (isCompleted ? 1.0 : 0.0);

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
              color: isCompleted
                  ? PremiumColors.success.withOpacity(0.2)
                  : isDownloading
                      ? PremiumColors.accentCyan.withOpacity(0.2)
                      : PremiumColors.error.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          PremiumColors.accentCyan.withOpacity(0.3),
                          PremiumColors.accentMagenta.withOpacity(0.3),
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
                          'Download ${index + 1}',
                          style: PremiumTypography.bodyLarge.copyWith(
                            color: PremiumColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(progress * 100).toStringAsFixed(0)}% • ${(index + 1) * 50}MB',
                          style: PremiumTypography.bodySmall.copyWith(
                            color: PremiumColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isCompleted
                        ? Icons.check_circle_rounded
                        : isDownloading
                            ? Icons.download_rounded
                            : Icons.error_rounded,
                    color: isCompleted
                        ? PremiumColors.success
                        : isDownloading
                            ? PremiumColors.accentCyan
                            : PremiumColors.error,
                    size: 28,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: PremiumColors.bg2,
                  valueColor: AlwaysStoppedAnimation(
                    isCompleted
                        ? PremiumColors.success
                        : isDownloading
                            ? PremiumColors.accentCyan
                            : PremiumColors.error,
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
