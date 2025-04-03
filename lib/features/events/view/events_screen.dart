import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/features/shared/components/news_app_bar.dart';
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
