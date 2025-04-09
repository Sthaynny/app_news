import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/router/app_router.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/extension/bool.dart';
import 'package:ufersa_hub/core/utils/extension/build_context.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/events/domain/models/events_model.dart';
import 'package:ufersa_hub/features/events/view/maneger/maneger_events_view_model.dart';
import 'package:ufersa_hub/features/shared/news/domain/enums/category_post.dart';

class ManegerEventsScreen extends StatefulWidget {
  const ManegerEventsScreen({super.key, required this.viewmodel, this.news});
  final ManegerEventsViewmodel viewmodel;
  final EventsModel? news;

  @override
  State<ManegerEventsScreen> createState() => _ManegerEventsScreenState();
}

class _ManegerEventsScreenState extends State<ManegerEventsScreen> {
  late final ManegerEventsViewmodel viewmodel;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ValueNotifier<CategoryPost> categoryNews = ValueNotifier(
    CategoryPost.other,
  );
  EventsModel? get event => widget.news;
  final form = GlobalKey<FormState>();

  @override
  void initState() {
    viewmodel = widget.viewmodel;
    viewmodel.createNews.addListener(_onResult);
    viewmodel.getPermission.addListener(_onResultPermission);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (event != null) {
      titleController.text = event!.title;
      descriptionController.text = event!.description ?? '';
      categoryNews.value = event!.category;
      viewmodel.init(event!);
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ManegerEventsScreen oldWidget) {
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
    categoryNews.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSHeader(
        title: event != null ? editEventString : createEventString,
      ),
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
              ValueListenableBuilder(
                valueListenable: categoryNews,
                builder: (_, value, __) {
                  return DSInputContainer(
                    padding: EdgeInsets.symmetric(
                      horizontal: DSSpacing.md.value,
                    ),
                    child: DropdownButton<CategoryPost>(
                      underline: const SizedBox.shrink(),
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(12),
                      icon: Icon(DSIcons.arrow_down_outline.data),
                      items:
                          CategoryPost.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: DSBodyText(e.labelPtBr),
                                ),
                              )
                              .toList(),
                      onChanged: (value) => categoryNews.value = value!,
                      value: value,
                    ),
                  );
                },
              ),
              DSSpacing.md.y,
              DSHeadlineSmallText(imagesString),
              ListenableBuilder(
                listenable: viewmodel.updateListImages,
                builder: (context, child) {
                  if (viewmodel.image != null) return Container();

                  final image = viewmodel.image!;
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: DSColors.primary.shade800),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Image.file(image),
                      trailing: DSIconButton(
                        onPressed: () {
                          viewmodel.removeImage( );
                        },
                        icon: DSIcons.trash_outline,
                        color: DSColors.error,
                      ),
                    ),
                  );
                },
              ),
              DSSpacing.md.y,

              ListenableBuilder(
                listenable: viewmodel.updateListImages,
                builder: (context, child) {
                  return SizedBox(
                    height: DSSpacing.xxxl.value,
                    child: DSSecondaryButton(
                      autoSize: false,
                      isLoading: viewmodel.updateListImages.running,
                      trailingIcon: Icon(
                        DSIcons.add_solid.data,
                        color: DSColors.primary.shade800,
                      ),
                      onPressed: () {
                        if (viewmodel.isPermissionGranted.isTrue) {
                          viewmodel.addImage();
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
                        categoryNews.value,
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
        viewmodel.addImage();
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
