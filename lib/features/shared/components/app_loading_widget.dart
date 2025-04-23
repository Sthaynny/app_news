import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: DSSpacing.xl.value),
      alignment: Alignment.center,
      child: DSSpinnerLoading(),
    );
  }
}
