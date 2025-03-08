import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DetailsNewsScreen extends StatefulWidget {
  const DetailsNewsScreen({super.key});

  @override
  State<DetailsNewsScreen> createState() => _DetailsNewsScreenState();
}

class _DetailsNewsScreenState extends State<DetailsNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSHeader(title: 'Detalhes', canPop: true),
      backgroundColor: DSColors.secundary,
    );
  }
}
