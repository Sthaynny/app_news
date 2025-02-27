import 'package:app_news/core/router/app_router.dart';
import 'package:app_news/features/login/screen/login_viewmodel.dart';
import 'package:app_news/features/login/utils/login_strings.dart';
import 'package:app_news/features/shared/components/news_app_bar.dart';
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
      appBar: NewsAppBar(
        canPop: true,
        onBackButtonPressed: () => context.go(AppRouters.home.path),
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
                    hint: LoginStrings.email.label,
                    textInputType: TextInputType.emailAddress,
                    isEnabled: !viewmodel.login.running,
                    validator: (value) {
                      return DSValidators().email(value);
                    },
                  ),
                  DSSpacing.md.y,
                  DSTextFormField(
                    hint: LoginStrings.password.label,
                    obscureText: true,
                    isEnabled: !viewmodel.login.running,
                  ),
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
          );
        },
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
