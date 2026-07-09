import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../theme/colors.dart';

/// u/[username] · public profile view
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(
        backgroundColor: AppColors.bg0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Ionicons.arrow_back_outline, size: 18, color: Colors.white),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('@mira.k', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Ionicons.share_social_outline, size: 18, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: const PreferredSize(preferredSize: Size.fromHeight(1), child: Divider(height: 1, color: AppColors.border1)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF4C1D95),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.borderWhite10, width: 2),
                ),
                alignment: Alignment.center,
                child: const Text('MK', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Colors.white)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Flexible(
                          child: Text('Mira K.',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: -0.2)),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.verified, size: 12, color: Color(0xFF3897F0)),
                      ],
                    ),
                    const SizedBox(height: 3),
                    const Text('@mira.k',
                        style: TextStyle(color: AppColors.textGray400, fontWeight: FontWeight.w700, fontSize: 12.5)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _stat('12.4K', 'Googers'),
              const SizedBox(width: 16),
              _stat('218', 'Following'),
            ],
          ),
          const SizedBox(height: 16),
          const Text('selling small-batch snacks on Shop. googing daily.',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500, color: AppColors.textGray200, height: 1.5)),
          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(Ionicons.link_outline, size: 14, color: AppColors.linkBlue),
              SizedBox(width: 6),
              Flexible(
                child: Text('googer.app/mira.k',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.linkBlue)),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentPurple,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                  ),
                  child: const Text('Follow', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.borderWhite10),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                  ),
                  child: const Text('Message', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderWhite10))),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 11),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
                  child: const Text('Products', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
                const SizedBox(width: 24),
                const Padding(
                  padding: EdgeInsets.only(bottom: 11),
                  child: Text('Googs', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.textGray500)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.78,
            children: [
              _productTile('Ginger Candy Pack', '120', Ionicons.nutrition_outline, [const Color(0xFF7C2D12), const Color(0xFF1A0A05)]),
              _productTile('Cold Brew Kit', '850', Ionicons.cafe_outline, [const Color(0xFF374151), const Color(0xFF0A0A0A)]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
        children: [
          TextSpan(text: value, style: const TextStyle(color: Colors.white)),
          TextSpan(text: ' $label', style: const TextStyle(color: AppColors.textGray500)),
        ],
      ),
    );
  }

  Widget _productTile(String title, String price, IconData icon, List<Color> gradient) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
      decoration: BoxDecoration(color: AppColors.shopCard, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: gradient),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 44, color: Colors.white.withOpacity(0.85)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 10, 4, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.textGray200)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Image.asset('assets/images/rupee.png',
                        width: 15, height: 9, fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Text('₹')),
                    const SizedBox(width: 6),
                    Text(price, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
