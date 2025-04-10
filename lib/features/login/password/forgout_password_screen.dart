import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/extension/build_context.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/login/password/forgout_password_viewmodel.dart';

class ForgoutPasswordScreen extends StatefulWidget {
  const ForgoutPasswordScreen({super.key, required this.viewmodel});
  final ForgoutPasswordViewmodel viewmodel;

  @override
  State<ForgoutPasswordScreen> createState() => _ForgoutPasswordScreenState();
}

class _ForgoutPasswordScreenState extends State<ForgoutPasswordScreen> {
  final form = GlobalKey<FormState>();
  final emailController = TextEditingController();

  late final ForgoutPasswordViewmodel viewmodel;
  @override
  void initState() {
    super.initState();
    viewmodel = widget.viewmodel;
    viewmodel.forgoutPassword.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant ForgoutPasswordScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewmodel.forgoutPassword.removeListener(_onResult);
    viewmodel.forgoutPassword.addListener(_onResult);
  }

  @override
  void dispose() {
    viewmodel.forgoutPassword.removeListener(_onResult);
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: DSLinearGradient(
            colors: [DSColors.primary, DSColors.secundary],
            degree: 10,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: ListenableBuilder(
                listenable: viewmodel.forgoutPassword,
                builder: (context, _) {
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
                          DSTextFormField(
                            controller: emailController,
                            hint: emailString,
                            textInputType: TextInputType.emailAddress,
                            isEnabled: !viewmodel.forgoutPassword.running,
                            validator: (value) {
                              return DSValidators().email(value);
                            },
                          ),

                          DSSpacing.md.y,
                          ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 48.0),
                            child: DSPrimaryButton(
                              label: redefinePasswordString,
                              isLoading: viewmodel.forgoutPassword.running,
                              onPressed: () {
                                if (form.currentState!.validate()) {
                                  viewmodel.forgoutPassword.execute(
                                    emailController.text,
                                  );
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
            ),
          ],
        ),
      ),
    );
  }

  void _onResult() {
    if (viewmodel.forgoutPassword.error) {
      viewmodel.forgoutPassword.clearResult();
      context.showSnackBarError(errorForgoutPasswordString);
      return;
    }
    if (viewmodel.forgoutPassword.completed &&
        (viewmodel.forgoutPassword.result?.isOk ?? false)) {
      viewmodel.forgoutPassword.clearResult();
      context.back(true);
    }
  }
}
