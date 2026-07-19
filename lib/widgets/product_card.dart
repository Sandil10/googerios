import 'package:flutter/material.dart';
import '../api/api.dart';
import '../data/mock.dart';
import '../theme.dart';
import 'kit.dart';
import 'product_popup.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard(this.product);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool liked = widget.product.liked;
  late int likes = widget.product.likes;

  Product get product => widget.product;

  String _fmt(int n) => n > 999 ? "${(n / 1000).toStringAsFixed(1)}k" : "$n";

  @override
  Widget build(BuildContext context) {
    final sale = product.oldPrice != null && product.oldPrice! > product.price
        ? "+${(100 - product.price / product.oldPrice! * 100).round()}%"
        : null;
    return GestureDetector(
      onTap: () => showProductPopup(context, product),
      child: Container(
        decoration: BoxDecoration(
          color: GoogerColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: GoogerColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 8, 6),
            child: Row(children: [
              GoogerAvatar(url: product.sellerAvatar.isEmpty ? null : product.sellerAvatar, name: product.seller, size: 24),
              const SizedBox(width: 7),
              Expanded(
                child: Text(product.seller,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
              const Icon(Icons.more_vert, size: 18, color: Colors.white70),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(children: [
                AspectRatio(
                  aspectRatio: 0.95,
                  child: product.image.isEmpty
                      ? const _ProductImageFallback()
                      : Image.network(product.image,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const _ProductImageFallback()),
                ),
                if (sale != null)
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF052F1F),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF0D8F52)),
                      ),
                      child: Text(sale,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF00FF88))),
                    ),
                  ),
              ]),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                const Spacer(),
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text("R",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: GoogerColors.dim)),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(product.price.toStringAsFixed(0),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ),
                  const Icon(Icons.shopping_cart_outlined, size: 18, color: Colors.white70),
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        liked = !liked;
                        likes += liked ? 1 : -1;
                      });
                      Api.toggleProductLike(product.id);
                    },
                    child: Row(children: [
                      Icon(liked ? Icons.favorite : Icons.favorite_border,
                          size: 15,
                          color: liked ? GoogerColors.red : Colors.white),
                      if (likes > 0) ...[
                        const SizedBox(width: 3),
                        Text(_fmt(likes),
                            style: const TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ],
                    ]),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.remove_red_eye_outlined,
                      size: 14, color: Colors.white),
                  const SizedBox(width: 3),
                  Text(_fmt(product.views),
                      style: const TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  const SizedBox(width: 12),
                  const Icon(Icons.mode_comment_outlined,
                      size: 13, color: Colors.white),
                  const SizedBox(width: 3),
                  Text(_fmt(product.comments),
                      style: const TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  const Spacer(),
                  const Icon(Icons.share_outlined, size: 14, color: Colors.white),
                ]),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class _ProductImageFallback extends StatelessWidget {
  const _ProductImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0B0B0C),
      alignment: Alignment.center,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.image_outlined, size: 22, color: GoogerColors.faint),
          SizedBox(height: 6),
          Text(
            "Product photo",
            style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w500, color: GoogerColors.faint),
          ),
        ],
      ),
    );
  }
}
