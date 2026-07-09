import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../theme/colors.dart';
import '../widgets/googer_topbar.dart';
import '../widgets/googer_bottom_nav.dart';
import '../models/goog.dart';
import 'shop_feed_screen.dart';
import 'wallet_screen.dart';
import 'chats_screen.dart';
import 'ad_campaign_screen.dart';
import '../services/goog_service.dart';
import '../services/current_user.dart';

/// 1c · Home Feed
class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  int _selectedTab = 0;

  List<Goog> _googs = const [];
  bool _feedLoading = true;
  bool _feedError = false;

  @override
  void initState() {
    super.initState();
    _loadFeed();
    CurrentUser.load();
  }

  Future<void> _loadFeed() async {
    setState(() {
      _feedLoading = true;
      _feedError = false;
    });
    try {
      final items = await GoogService.feed();
      final palette = AppColors.avatarPalette;
      final parsed = <Goog>[];
      for (var i = 0; i < items.length; i++) {
        final item = items[i];
        if (item is Map<String, dynamic>) {
          parsed.add(Goog.fromJson(item, avatarBg: palette[i % palette.length]));
        }
      }
      if (!mounted) return;
      setState(() {
        _googs = parsed;
        _feedLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      // Fall back to demo data so the feed is never blank on network failure.
      setState(() {
        _googs = demoGoogs;
        _feedError = true;
        _feedLoading = false;
      });
    }
  }

  Widget _buildHomeFeed() {
    if (_feedLoading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.accentPurple));
    }
    final list = _googs.isEmpty ? demoGoogs : _googs;
    return RefreshIndicator(
      color: AppColors.accentPurple,
      onRefresh: _loadFeed,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(14, 4, 14, 8),
        itemCount: list.length + (_feedError ? 1 : 0),
        itemBuilder: (context, i) {
          if (_feedError && i == 0) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8, top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.bg2,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.inputBorder),
              ),
              child: Row(
                children: [
                  const Icon(Ionicons.cloud_offline_outline, size: 15, color: AppColors.textGray400),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('Offline — showing sample feed. Pull to retry.',
                        style: TextStyle(fontSize: 11, color: AppColors.textGray400)),
                  ),
                ],
              ),
            );
          }
          final goog = list[i - (_feedError ? 1 : 0)];
          return _GoogCard(goog: goog);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: const GoogerTopbar(title: 'Googer'),
      body: _buildScreen(_selectedTab),
      bottomNavigationBar: GoogerBottomNav(
        active: _getTabFromIndex(_selectedTab),
        onTap: (tab) {
          setState(() {
            _selectedTab = _getIndexFromTab(tab);
          });
        },
        onAddTap: () => AdCampaignScreen.showCreateSheet(context),
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0: // Home
        return _buildHomeFeed();
      case 1: // Shop
        return const ShopFeedScreen();
      case 2: // Add (placeholder)
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add_circle_outline, size: 80, color: AppColors.textGray500),
              SizedBox(height: 16),
              Text('Create New Post', style: TextStyle(color: Colors.white, fontSize: 15)),
            ],
          ),
        );
      case 3: // Wallet
        return const WalletScreen();
      case 4: // Chat
        return const ChatsScreen();
      default:
        return _buildHomeFeed();
    }
  }

  GoogerTab _getTabFromIndex(int index) {
    switch (index) {
      case 0:
        return GoogerTab.home;
      case 1:
        return GoogerTab.shop;
      case 3:
        return GoogerTab.wallet;
      case 4:
        return GoogerTab.chats;
      default:
        return GoogerTab.home;
    }
  }

  int _getIndexFromTab(GoogerTab tab) {
    switch (tab) {
      case GoogerTab.home:
        return 0;
      case GoogerTab.shop:
        return 1;
      case GoogerTab.wallet:
        return 3;
      case GoogerTab.chats:
        return 4;
    }
  }
}

class _GoogCard extends StatelessWidget {
  final Goog goog;
  const _GoogCard({required this.goog});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderWhite06, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.only(top: 1),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: goog.avatarBg, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: goog.imageUrl != null
                ? Image.network(
                    goog.imageUrl!,
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Text(goog.initial,
                        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 10.5)),
                  )
                : Text(goog.initial, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 10.5)),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              goog.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(goog.time, style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.4))),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.purpleBg10,
                            borderRadius: BorderRadius.circular(9999),
                            border: Border.all(color: AppColors.accentPurple.withOpacity(0.3)),
                          ),
                          child: const Text('Subscribe', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, color: AppColors.purpleText)),
                        ),
                        const SizedBox(width: 6),
                        Text('•••', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.4), letterSpacing: 1)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(goog.text, style: const TextStyle(fontSize: 12.5, height: 18 / 12.5, fontWeight: FontWeight.w400, color: AppColors.textGray200)),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Icon(goog.liked ? Ionicons.heart : Ionicons.heart_outline, size: 17, color: goog.liked ? AppColors.likeRed : Colors.white),
                    const SizedBox(width: 14),
                    const Icon(Ionicons.chatbubble_outline, size: 17, color: Colors.white),
                    const SizedBox(width: 14),
                    const Icon(Ionicons.eye_outline, size: 17, color: Colors.white),
                    const SizedBox(width: 14),
                    const Icon(Ionicons.share_social_outline, size: 17, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '${goog.likes} likes, ${goog.comments} comments, ${goog.views} views, ${goog.shares} shares',
                  style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.4)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
