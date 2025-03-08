import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/features/shared/news/domain/models/news_model.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DetailsNewsScreen extends StatelessWidget {
  const DetailsNewsScreen({super.key, required this.news});
  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSHeader(title: detailsNewsString, canPop: true),
      backgroundColor: DSColors.secundary,
    );
  }
}
