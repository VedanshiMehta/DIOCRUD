import 'package:flutter/material.dart';

class RoundImage extends StatelessWidget {
  const RoundImage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(80),
      child: Image.network(
        imageUrl,
        height: 60,
        width: 60,
        fit: BoxFit.fill,
      ),
    );
  }
}
