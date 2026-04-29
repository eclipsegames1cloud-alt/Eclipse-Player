import 'package:flutter/material.dart';
import '../theme/premium_theme.dart';

class DownloadDetailsScreen extends StatefulWidget {
  const DownloadDetailsScreen({Key? key}) : super(key: key);

  @override
  State<DownloadDetailsScreen> createState() => _DownloadDetailsScreenState();
}

class _DownloadDetailsScreenState extends State<DownloadDetailsScreen> {
  double _downloadSpeed = 5.2; // MB/s

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PremiumColors.bg0,
      appBar: AppBar(
        backgroundColor: PremiumColors.bg0,
        elevation: 0,
        title: Text(
          'Download Details',
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: PremiumColors.bg1,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: PremiumColors.accentCyan.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
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
                          Icons.download_rounded,
                          color: Colors.white54,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Video Download',
                              style: PremiumTypography.bodyLarge.copyWith(
                                color: PremiumColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '720 MB / 1.2 GB',
                              style: PremiumTypography.bodySmall.copyWith(
                                color: PremiumColors.textTertiary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: 0.6,
                                minHeight: 4,
                                backgroundColor: PremiumColors.bg2,
                                valueColor: AlwaysStoppedAnimation(
                                  PremiumColors.accentCyan,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '60% - 45s remaining',
                              style: PremiumTypography.bodySmall.copyWith(
                                color: PremiumColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Download Details',
              style: PremiumTypography.headingSmall.copyWith(
                color: PremiumColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            _buildDetailTile('Speed', '${_downloadSpeed} MB/s'),
            _buildDetailTile('Downloaded', '720 MB'),
            _buildDetailTile('Total Size', '1.2 GB'),
            _buildDetailTile('Quality', '720p'),
            _buildDetailTile('Format', 'MP4'),
            _buildDetailTile('Time Left', '45 seconds'),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.pause_rounded),
                    label: const Text('Pause'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PremiumColors.accentMagenta,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.close_rounded),
                    label: const Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PremiumColors.error,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: PremiumTypography.bodySmall.copyWith(
              color: PremiumColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: PremiumTypography.bodySmall.copyWith(
              color: PremiumColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
