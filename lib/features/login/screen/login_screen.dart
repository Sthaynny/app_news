import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/router/app_router.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/extension/build_context.dart';
import 'package:ufersa_hub/features/login/screen/login_viewmodel.dart';
import 'package:ufersa_hub/features/shared/components/app_icon.dart';

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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height + 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: DSLinearGradient(
            colors: [DSColors.primary, DSColors.secundary],
            degree: 10,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListenableBuilder(
                listenable: viewmodel.login,
                builder: (__, _) {
                  return Container(
                    padding: EdgeInsets.all(DSSpacing.md.value),
                    margin: EdgeInsets.all(DSSpacing.md.value),
                    decoration: BoxDecoration(
                      color: DSColors.neutralMediumWave,
                      borderRadius: BorderRadius.circular(DSSpacing.lg.value),
                    ),
                    child: Form(
                      key: form,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: BackButton(color: DSColors.primary),
                          ),
                          DSSpacing.md.y,
                          AppIcon.hub(scale: 5),
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
                          DSSpacing.lg.y,
                          Align(
                            alignment: Alignment.centerRight,
                            child: DSTertiaryButton(
                              onPressed: () async {
                                final result = await context.go(
                                  AppRouters.forgoutPassword,
                                );
                                if (result != null) {
                                  // ignore: use_build_context_synchronously
                                  context.showSnackBarSuccess(
                                    forgotPasswordSuccessString,
                                  );
                                }
                              },
                              label: forgotPasswordString,
                            ),
                          ),
                          DSSpacing.md.y,
                          ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 48.0),
                            child: DSPrimaryButton(
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
                          ),
                        ],
                      ),
                    ),
                  );
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
      context.go(AppRouters.home);
    }

    if (viewmodel.login.error) {
      viewmodel.login.clearResult();
      context.showSnackBarError(credenciaisInvalidasString);
    }
  }
}
