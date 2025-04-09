import 'dart:convert';

import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.imageBase64, this.height});
  final String imageBase64;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.memory(
        base64Decode(imageBase64),
        height: height ?? 200,
        width: double.maxFinite,
        fit: BoxFit.cover,
      ),
    );
  }
}
