import 'dart:convert';

import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.imageBase64});
  final String imageBase64;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.memory(
        base64Decode(imageBase64),
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
