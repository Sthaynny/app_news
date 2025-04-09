import 'dart:convert';

import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.imageBase64,
    this.height,
    this.fit,
  });
  final String imageBase64;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.memory(
        base64Decode(imageBase64),
        height: height ?? 200,
        width: double.maxFinite,
        fit: fit ?? BoxFit.cover,
      ),
    );
  }
}
