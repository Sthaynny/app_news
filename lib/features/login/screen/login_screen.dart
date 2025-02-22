import 'package:app_news/features/login/utils/login_strings.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSHeader(title: LoginStrings.login.label),
      body: Column(
        children: [
          DSSpacing.md.y,
          DSTextField(
            hint: LoginStrings.email.label,
            textInputType: TextInputType.emailAddress,
          ),
          DSSpacing.md.y,
          DSTextField(hint: LoginStrings.password.label, obscureText: true),
          DSSpacing.md.y,
          DSButton(
            label: LoginStrings.login.label,
            onPressed: () {},
            backgroundColor: DSColors.primary,
            foregroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
