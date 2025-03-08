import 'package:app_news/core/router/app_router.dart';
import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/core/utils/extension/build_context.dart';
import 'package:app_news/features/login/screen/login_viewmodel.dart';
import 'package:app_news/features/shared/components/news_app_bar.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.viewmodel});
  final LoginViewModel viewmodel;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final form = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late final LoginViewModel viewmodel;
  @override
  void initState() {
    super.initState();
    viewmodel = widget.viewmodel;
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
      appBar: NewsAppBar(
        canPop: true,
        onBackButtonPressed: () => context.go(AppRouters.home),
      ),
      body: ListenableBuilder(
        listenable: viewmodel.login,
        builder: (context, _) {
          return Padding(
            padding: EdgeInsets.all(DSSpacing.md.value),
            child: Form(
              key: form,
              child: Column(
                children: [
                  DSSpacing.md.y,
                  DSTextFormField(
                    controller: emailController,
                    hint: emailString,
                    textInputType: TextInputType.emailAddress,
                    isEnabled: !viewmodel.login.running,
                    validator: (value) {
                      return DSValidators().email(value);
                    },
                  ),
                  DSSpacing.md.y,
                  DSTextFormField(
                    controller: passwordController,
                    hint: passwordString,
                    obscureText: true,
                    isEnabled: !viewmodel.login.running,
                  ),
                  DSSpacing.md.y,
                  DSPrimaryButton(
                    label: loginString,
                    isLoading: viewmodel.login.running,
                    onPressed: () {
                      if (form.currentState!.validate()) {
                        viewmodel.login.execute((
                          emailController.text,
                          passwordController.text,
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onResult() {
    if (viewmodel.login.completed) {
      viewmodel.login.clearResult();
      context.go(AppRouters.home);
    }

    if (viewmodel.login.error) {
      viewmodel.login.clearResult();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: DSCaptionSmallText(errorDefaultString)));
    }
  }
}
