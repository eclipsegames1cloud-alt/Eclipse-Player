import 'package:flutter/material.dart';
import '../theme/premium_theme.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({Key? key}) : super(key: key);

  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
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
                  'Browser',
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
                const SizedBox(height: 16),
                _buildSearchBar(),
                const SizedBox(height: 24),
                _buildFeaturedSection(),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [
            PremiumColors.accentCyan.withOpacity(0.1),
            PremiumColors.accentMagenta.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: PremiumColors.accentCyan.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: _searchController,
        style: PremiumTypography.bodyLarge.copyWith(
          color: PremiumColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: 'Search videos, music...',
          hintStyle: PremiumTypography.bodyLarge.copyWith(
            color: PremiumColors.textTertiary,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: PremiumColors.accentCyan,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Content',
          style: PremiumTypography.headingSmall.copyWith(
            color: PremiumColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildContentCard(index),
            );
          },
        ),
      ],
    );
  }

  Widget _buildContentCard(int index) {
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
              color: PremiumColors.accentCyan.withOpacity(0.15),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      PremiumColors.accentCyan.withOpacity(0.3),
                      PremiumColors.accentMagenta.withOpacity(0.3),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.video_library_rounded,
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
                      'Content ${index + 1}',
                      style: PremiumTypography.bodyLarge.copyWith(
                        color: PremiumColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Channel ${index + 1}',
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
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
