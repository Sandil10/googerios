import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../theme/colors.dart';
import 'flash_content_screen.dart';
import 'photo_video_ad_screen.dart';
import 'product_promote_screen.dart';
import 'profile_promote_screen.dart';
import 'upload_content_screen.dart';

/// 1i · Ad Campaign
class AdCampaignScreen extends StatelessWidget {
  const AdCampaignScreen({super.key});

  static void showCreateSheet(BuildContext context) => _chooseCampaignType(context);

  static void _chooseCampaignType(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bg3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (sheetCtx) {
        Widget tile(String title, String subtitle, IconData icon, Widget dest) {
          return InkWell(
            onTap: () {
              Navigator.pop(sheetCtx);
              Navigator.push(context, MaterialPageRoute(builder: (_) => dest));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(color: AppColors.purpleBg15, shape: BoxShape.circle),
                    child: Icon(icon, size: 18, color: AppColors.purpleText),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                        const SizedBox(height: 2),
                        Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11, color: AppColors.textGray500)),
                      ],
                    ),
                  ),
                  const Icon(Ionicons.chevron_forward, size: 15, color: AppColors.textGray500),
                ],
              ),
            ),
          );
        }

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(18, 16, 18, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Create Campaign', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
              tile('Flash Content', 'Short-lived video ad', Ionicons.flash_outline, const FlashContentScreen()),
              tile('Photo / Video Ad', 'Standard media campaign', Ionicons.images_outline, const PhotoVideoAdScreen()),
              tile('Product Promote', 'Boost a shop product', Ionicons.pricetag_outline, const ProductPromoteScreen()),
              tile('Profile Promote', 'Grow your audience', Ionicons.person_outline, const ProfilePromoteScreen()),
              tile('Upload Content', 'Vault / subscriber content', Ionicons.cloud_upload_outline, const UploadContentScreen()),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(
        backgroundColor: AppColors.bg0,
        elevation: 0,
        title: const Text('Ad Campaigns', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: Colors.white)),
        bottom: const PreferredSize(preferredSize: Size.fromHeight(1), child: Divider(height: 1, color: AppColors.border1)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _campaignCard(
            'Ginger Candy Promo',
            '2,450 impressions',
            '₹500',
            AppColors.successGreen,
            'Active',
          ),
          _campaignCard(
            'Summer Sale Campaign',
            '1,200 impressions',
            '₹300',
            AppColors.utilityBlue,
            'Paused',
          ),
          _campaignCard(
            'New Product Launch',
            '450 impressions',
            '₹200',
            AppColors.likeRed,
            'Ended',
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _chooseCampaignType(context),
            icon: const Icon(Ionicons.add_circle_outline),
            label: const Text('Create New Campaign'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentPurple,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _campaignCard(String title, String stats, String budget, Color statusColor, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: statusColor)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(stats, style: const TextStyle(fontSize: 11, color: AppColors.textGray500)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(budget, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
              Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textGray600),
            ],
          ),
        ],
      ),
    );
  }
}
