import 'package:flutter/material.dart';
import '../theme/premium_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = true;
  bool _notifications = true;
  bool _autoDownload = false;

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
                  'Settings',
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
                const SizedBox(height: 16),
                _buildSection(
                  'Display',
                  [
                    _buildToggleTile(
                      'Dark Mode',
                      'Enable dark theme',
                      _darkMode,
                      (value) => setState(() => _darkMode = value),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSection(
                  'Notifications',
                  [
                    _buildToggleTile(
                      'Push Notifications',
                      'Receive updates and alerts',
                      _notifications,
                      (value) => setState(() => _notifications = value),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSection(
                  'Downloads',
                  [
                    _buildToggleTile(
                      'Auto Download',
                      'Automatically download new content',
                      _autoDownload,
                      (value) => setState(() => _autoDownload = value),
                    ),
                    _buildSettingsTile(
                      'Download Location',
                      'Internal Storage',
                      Icons.folder_rounded,
                    ),
                    _buildSettingsTile(
                      'Download Quality',
                      'High (1080p)',
                      Icons.hd_rounded,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSection(
                  'About',
                  [
                    _buildSettingsTile(
                      'Version',
                      '1.0.0',
                      Icons.info_rounded,
                    ),
                    _buildSettingsTile(
                      'Privacy Policy',
                      'Read our policy',
                      Icons.privacy_tip_rounded,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: PremiumTypography.headingSmall.copyWith(
            color: PremiumColors.accentPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: PremiumColors.bg1,
            border: Border.all(
              color: PremiumColors.accentPrimary.withOpacity(0.1),
            ),
          ),
          child: Column(
            children: List.generate(
              children.length,
              (index) => Column(
                children: [
                  children[index],
                  if (index < children.length - 1)
                    Divider(
                      color: PremiumColors.bg2,
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: PremiumTypography.bodyLarge.copyWith(
                  color: PremiumColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: PremiumColors.accentPrimary,
            activeTrackColor: PremiumColors.accentPrimary.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    String title,
    String value,
    IconData icon,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: PremiumColors.accentPrimary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: PremiumTypography.bodyLarge.copyWith(
                          color: PremiumColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        value,
                        style: PremiumTypography.bodySmall.copyWith(
                          color: PremiumColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: PremiumColors.textTertiary,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
