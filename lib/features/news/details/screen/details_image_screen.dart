import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsImageScreen extends StatelessWidget {
  const DetailsImageScreen({super.key, required this.heroImage});
  final Hero heroImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: InkWell(
        onTap: context.pop,
        child: InteractiveViewer(child: Center(child: heroImage)),
      ),
    );
  }
}
