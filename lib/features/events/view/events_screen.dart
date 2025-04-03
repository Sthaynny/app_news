import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/features/shared/components/news_app_bar.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsAppBar(canPop: true, title: eventsString),
      body: Column(children: []),
    );
  }
}
