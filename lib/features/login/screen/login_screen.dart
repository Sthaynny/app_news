import 'package:app_news/core/router/app_router.dart';
import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/features/login/screen/login_viewmodel.dart';
import 'package:app_news/features/login/utils/login_strings.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.viewmodel});
  final LoginViewModel viewmodel;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final form = GlobalKey<FormState>();

  LoginViewModel get viewmodel => widget.viewmodel;
  @override
  void initState() {
    super.initState();
    viewmodel.login.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant LoginScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewmodel.login.removeListener(_onResult);
    viewmodel.login.addListener(_onResult);
  }

  @override
  void dispose() {
    viewmodel.login.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSHeader(
        title: LoginStrings.login.label,
        customTitle: Row(
          children: [
            DSSpacing.sm.x,
            DSAnimatedSize(
              child: Image.asset("assets/images/world-news.png", scale: 15),
            ),
            DSSpacing.sm.x,
            DSHeadlineSmallText(StringsApp.appName.label),
          ],
        ),
        canPop: true,
        onBackButtonPressed: () => context.go(AppRouters.home.path),
      ),
      body: Padding(
        padding: EdgeInsets.all(DSSpacing.md.value),
        child: Form(
          key: form,
          child: Column(
            children: [
              DSSpacing.md.y,
              DSTextFormField(
                hintText: LoginStrings.email.label,
                textInputType: TextInputType.emailAddress,
              ),
              DSSpacing.md.y,
              DSTextField(hint: LoginStrings.password.label, obscureText: true),
              DSSpacing.md.y,
              DSPrimaryButton(
                label: LoginStrings.login.label,
                onPressed: () {
                  if (form.currentState!.validate()) {
                    // context.go(AppRouters.home.path);
                    // viewmodel.login.execute(('email', 'password'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onResult() {
    if (viewmodel.login.completed) {
      viewmodel.login.clearResult();
      // context.go(AppRouters.home.path);
    }

    if (viewmodel.login.error) {
      viewmodel.login.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error'),
          action: SnackBarAction(
            label: 'Tente novamente',
            onPressed: () {}, // viewmodel.login.execute(('email', 'password')),
          ),
        ),
      );
    }
  }
}
