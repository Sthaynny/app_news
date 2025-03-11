import 'package:app_news/core/router/app_router.dart';
import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/core/utils/extension/bool.dart';
import 'package:app_news/core/utils/extension/build_context.dart';
import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/news/create/create_news_viewmodel.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CreateNewsScreen extends StatefulWidget {
  const CreateNewsScreen({super.key, required this.viewmodel});
  final CreateNewsViewmodel viewmodel;

  @override
  State<CreateNewsScreen> createState() => _CreateNewsScreenState();
}

class _CreateNewsScreenState extends State<CreateNewsScreen> {
  late final CreateNewsViewmodel viewmodel;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    viewmodel = widget.viewmodel;
    viewmodel.createNews.addListener(_onResult);
    viewmodel.getPermission.addListener(_onResultPermission);
  }

  @override
  void didUpdateWidget(covariant CreateNewsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewmodel.createNews.removeListener(_onResult);
    viewmodel.createNews.addListener(_onResult);
    oldWidget.viewmodel.getPermission.removeListener(_onResultPermission);
    viewmodel.getPermission.addListener(_onResultPermission);
  }

  @override
  void dispose() {
    viewmodel.createNews.removeListener(_onResult);
    viewmodel.getPermission.removeListener(_onResultPermission);
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSHeader(title: createNewsString),
      body: Form(
        key: form,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(DSSpacing.md.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DSSpacing.md.y,
              DSTextFormField(
                controller: titleController,
                hint: titleString,
                validator:
                    (value) =>
                        value?.isEmpty ?? false ? mandatoryTitleString : null,
              ),
              DSSpacing.md.y,
              DSHeadlineSmallText(descriptionString),
              DSTextField(
                controller: descriptionController,
                hint: descriptionString,
                // maxLines: 15,
              ),
              DSSpacing.md.y,
              DSHeadlineSmallText(imagesString),
              ListenableBuilder(
                listenable: viewmodel.manegesImages,
                builder: (context, child) {
                  if (viewmodel.images.isEmpty) return Container();
                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: DSSpacing.xs.value,
                    mainAxisSpacing: DSSpacing.xs.value,
                    childAspectRatio: 1.5,

                    children:
                        viewmodel.images.indexed
                            .map(
                              (e) => Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: DSColors.primary.shade800,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Image.file(e.$2),
                                  trailing: DSIconButton(
                                    onPressed: () {
                                      viewmodel.manegesImages.execute(e.$1);
                                    },
                                    icon: DSIcons.trash_outline,
                                    color: DSColors.error,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  );
                },
              ),
              DSSpacing.md.y,

              ListenableBuilder(
                listenable: viewmodel.manegesImages,
                builder: (context, child) {
                  return SizedBox(
                    height: DSSpacing.xxxl.value,
                    child: DSSecondaryButton(
                      autoSize: false,
                      isLoading: viewmodel.manegesImages.running,
                      trailingIcon: Icon(
                        DSIcons.add_solid.data,
                        color: DSColors.primary.shade800,
                      ),
                      onPressed: () {
                        if (viewmodel.isPermissionGranted.isTrue) {
                          viewmodel.manegesImages.execute(null);
                        } else {
                          viewmodel.getPermission.execute();
                        }
                      },
                      label: addImageString,
                    ),
                  );
                },
              ),
              DSSpacing.md.y,
              SizedBox(
                height: DSSpacing.xxxl.value,
                child: DSPrimaryButton(
                  autoSize: false,
                  onPressed: () {
                    if (form.currentState?.validate() ?? false) {
                      viewmodel.createNews.execute((
                        titleController.text,
                        descriptionController.text,
                      ));
                    } else {
                      context.showSnackBarError(errorDefaultString);
                    }
                  },
                  label: saveString,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onResult() {
    if (viewmodel.createNews.completed) {
      viewmodel.createNews.clearResult();
      context.go(AppRouters.home);
    }

    if (viewmodel.createNews.error) {
      viewmodel.createNews.clearResult();
      context.showSnackBarError(errorDefaultString);
    }
  }

  void _onResultPermission() {
    if (viewmodel.getPermission.completed) {
      final result = viewmodel.getPermission.result;
      if (result?.value.isTrue ?? false) {
        viewmodel.manegesImages.execute(null);
      } else {
        context.showSnackBarInfo(
          permissionDeniedString,
          action: SnackBarAction(
            label: openSettingsString,
            onPressed: () {
              viewmodel.openAppSettings();
            },
          ),
        );
      }
      viewmodel.getPermission.clearResult();
    }
  }
}
