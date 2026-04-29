import 'package:flutter/material.dart';
import '../theme/premium_theme.dart';

class AdvancedSettingsScreen extends StatefulWidget {
  const AdvancedSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AdvancedSettingsScreen> createState() => _AdvancedSettingsScreenState();
}

class _AdvancedSettingsScreenState extends State<AdvancedSettingsScreen> {
  bool _hardwareAcceleration = true;
  bool _caching = true;
  bool _logging = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PremiumColors.bg0,
      appBar: AppBar(
        backgroundColor: PremiumColors.bg0,
        elevation: 0,
        title: Text(
          'Advanced Settings',
          style: PremiumTypography.headingSmall.copyWith(
            color: PremiumColors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: PremiumColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            'Performance',
            [
              _buildToggleTile(
                'Hardware Acceleration',
                'Enable for better performance',
                _hardwareAcceleration,
                (value) => setState(() => _hardwareAcceleration = value),
              ),
              _buildToggleTile(
                'Caching',
                'Cache downloaded content',
                _caching,
                (value) => setState(() => _caching = value),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Development',
            [
              _buildToggleTile(
                'Debug Logging',
                'Enable debug logs',
                _logging,
                (value) => setState(() => _logging = value),
              ),
              _buildTile(
                'Clear Cache',
                'Remove all cached data',
                Icons.delete_rounded,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Storage',
            [
              _buildTile(
                'App Cache Size',
                '256 MB',
                Icons.storage_rounded,
              ),
              _buildTile(
                'Clear All Data',
                'This cannot be undone',
                Icons.warning_rounded,
                isDangerous: true,
              ),
            ],
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
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
    String title,
    String subtitle,
    IconData icon, {
    bool isDangerous = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                color: isDangerous ? PremiumColors.error : PremiumColors.accentPrimary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: PremiumTypography.bodyLarge.copyWith(
                        color: isDangerous ? PremiumColors.error : PremiumColors.textPrimary,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
