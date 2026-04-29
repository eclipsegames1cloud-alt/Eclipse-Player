import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/extended_models.dart';
import '../utils/extensions.dart';

/// ✨ IMPROVED: Social media sharing functionality
/// تحسين: مشاركة سهلة على منصات التواصل الاجتماعي
class SocialShareWidget {
  /// ✨ IMPROVED: Share media with custom message
  /// تحسين: مشاركة الوسائط برسالة مخصصة
  static Future<void> shareMedia(
    MediaItem media, {
    String? customMessage,
  }) async {
    try {
      final message = customMessage ?? 
          'شاهد هذا على Eclipse Player!\n${media.title}\n${media.url}';
      
      await Share.share(
        message,
        subject: media.title,
      );
    } catch (e) {
      print('خطأ في المشاركة: $e');
    }
  }

  /// ✨ IMPROVED: Share to specific social platform
  /// تحسين: مشاركة على منصات محددة
  static Future<void> shareToSocialMedia(
    MediaItem media,
    SocialPlatform platform,
  ) async {
    try {
      final message = 'شاهد: ${media.title}';
      final url = Uri.encodeComponent(media.url);
      
      switch (platform) {
        case SocialPlatform.whatsapp:
          // تحسين: مشاركة على WhatsApp
          final whatsappUrl = 'https://wa.me/?text=$message\n$url';
          if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
            await launchUrl(Uri.parse(whatsappUrl));
          }
          break;
          
        case SocialPlatform.facebook:
          // تحسين: مشاركة على Facebook
          final facebookUrl = 'https://www.facebook.com/sharer/sharer.php?u=$url';
          if (await canLaunchUrl(Uri.parse(facebookUrl))) {
            await launchUrl(Uri.parse(facebookUrl));
          }
          break;
          
        case SocialPlatform.twitter:
          // تحسين: مشاركة على Twitter
          final twitterUrl = 'https://twitter.com/intent/tweet?text=$message&url=$url';
          if (await canLaunchUrl(Uri.parse(twitterUrl))) {
            await launchUrl(Uri.parse(twitterUrl));
          }
          break;
          
        case SocialPlatform.telegram:
          // تحسين: مشاركة على Telegram
          final telegramUrl = 'https://t.me/share/url?url=$url&text=$message';
          if (await canLaunchUrl(Uri.parse(telegramUrl))) {
            await launchUrl(Uri.parse(telegramUrl));
          }
          break;
          
        case SocialPlatform.instagram:
          // تحسين: فتح Instagram
          if (await canLaunchUrl(Uri.parse('https://www.instagram.com'))) {
            await launchUrl(Uri.parse('https://www.instagram.com'));
          }
          break;
      }
    } catch (e) {
      print('خطأ في مشاركة ${platform.name}: $e');
    }
  }

  /// ✨ IMPROVED: Copy link to clipboard
  /// تحسين: نسخ الرابط للحافظة
  static Future<void> copyLinkToClipboard(String url) async {
    try {
      await Share.share(url);
    } catch (e) {
      print('خطأ في نسخ الرابط: $e');
    }
  }
}

/// ✨ IMPROVED: Social platform enum
/// تحسين: قائمة منصات التواصل الاجتماعي
enum SocialPlatform {
  whatsapp('WhatsApp', Icons.message),
  facebook('Facebook', Icons.facebook),
  twitter('Twitter', Icons.share),
  telegram('Telegram', Icons.send),
  instagram('Instagram', Icons.photo_camera);

  final String label;
  final IconData icon;

  const SocialPlatform(this.label, this.icon);
}

/// ✨ IMPROVED: Social share bottom sheet widget
/// تحسين: نافذة مشاركة المنصات الاجتماعية
class SocialShareBottomSheet extends StatelessWidget {
  final MediaItem media;

  const SocialShareBottomSheet({
    Key? key,
    required this.media,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppRadius.xl),
          topRight: Radius.circular(AppRadius.xl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // تحسين: عنوان النافذة
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              'شارك على',
              style: AppTypography.headlineSmall,
            ),
          ),
          
          // تحسين: شبكة منصات التواصل
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: AppSpacing.lg,
                crossAxisSpacing: AppSpacing.lg,
              ),
              itemCount: SocialPlatform.values.length,
              itemBuilder: (context, index) {
                final platform = SocialPlatform.values[index];
                return _buildPlatformButton(context, platform);
              },
            ),
          ),
          
          // تحسين: خيار نسخ الرابط
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  SocialShareWidget.copyLinkToClipboard(media.url);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.copy),
                label: const Text('نسخ الرابط'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildPlatformButton(
    BuildContext context,
    SocialPlatform platform,
  ) {
    return GestureDetector(
      onTap: () {
        SocialShareWidget.shareToSocialMedia(media, platform);
        Navigator.pop(context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              borderRadius: AppRadius.radiusMd,
            ),
            child: Icon(
              platform.icon,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            platform.label,
            style: AppTypography.labelSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// ✨ IMPROVED: Share button for quick access
/// تحسين: زر المشاركة السريعة
class ShareButton extends StatelessWidget {
  final MediaItem media;

  const ShareButton({
    Key? key,
    required this.media,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      color: AppColors.primary,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => SocialShareBottomSheet(media: media),
        );
      },
    );
  }
}
