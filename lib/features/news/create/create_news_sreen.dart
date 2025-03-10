import 'package:app_news/core/strings/strings.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CreateNewsSreen extends StatefulWidget {
  const CreateNewsSreen({super.key});

  @override
  State<CreateNewsSreen> createState() => _CreateNewsSreenState();
}

class _CreateNewsSreenState extends State<CreateNewsSreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: DSHeader(title: createNewsString), body: SingleChildScrollView(
      child: Column(
        children: [
          
        ],
      ),
    ),);
  }
}
