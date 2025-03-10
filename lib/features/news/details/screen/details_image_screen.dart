import 'package:app_news/core/utils/extension/build_context.dart';
import 'package:flutter/material.dart';

class DetailsImageScreen extends StatelessWidget {
  const DetailsImageScreen({super.key, required this.heroImage});
  final Widget heroImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: InkWell(
        onTap: context.back,
        child: InteractiveViewer(child: Center(child: heroImage)),
      ),
    );
  }
}
