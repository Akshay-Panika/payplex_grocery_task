import 'package:flutter/material.dart';
import '../constant/app_color.dart';

class SafeNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final double iconSize;

  const SafeNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;

    // EMPTY / NULL CASE
    if (url == null || url.trim().isEmpty) {
      return _placeholder();
    }

    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,

      // LOADING STATE
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;

        return _placeholder();
      },

      // ERROR STATE
      errorBuilder: (context, error, stackTrace) {
        return _placeholder();
      },
    );
  }

  Widget _placeholder() {
    return Center(
      child: Icon(
        Icons.image_not_supported_outlined,
        size: iconSize,
        color: AppColor.muted,
      ),
    );
  }
}