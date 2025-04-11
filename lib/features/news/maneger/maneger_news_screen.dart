import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/router/app_router.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/extension/bool.dart';
import 'package:ufersa_hub/core/utils/extension/build_context.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/news/maneger/maneger_news_viewmodel.dart';
import 'package:ufersa_hub/features/shared/domain/enums/category_post.dart';
import 'package:ufersa_hub/features/shared/domain/enums/course_hub.dart';
import 'package:ufersa_hub/features/shared/news/domain/models/news_model.dart';

class CreateNewsScreen extends StatefulWidget {
  const CreateNewsScreen({super.key, required this.viewmodel, this.news});
  final ManegerNewsViewmodel viewmodel;
  final NewsModel? news;

  @override
  State<CreateNewsScreen> createState() => _CreateNewsScreenState();
}

class _CreateNewsScreenState extends State<CreateNewsScreen> {
  late final ManegerNewsViewmodel viewmodel;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ValueNotifier<CategoryPost> categoryNotifier = ValueNotifier(
    CategoryPost.other,
  );
  final ValueNotifier<CourseHub?> courseNotifier = ValueNotifier(null);
  NewsModel? get news => widget.news;
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
    if (news != null) {
      titleController.text = news!.title;
      descriptionController.text = news!.description ?? '';
      categoryNotifier.value = news!.categoryNews;
      courseNotifier.value = news!.course;
      viewmodel.init(news!);
    }
    super.didChangeDependencies();
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
    categoryNotifier.dispose();
    courseNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSHeader(title: news != null ? editNewsString : createNewsString),
      body: Form(
        key: form,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(DSSpacing.md.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DSSpacing.xs.y,
              DSHeadlineSmallText(titleString),
              DSSpacing.xs.y,
              DSTextFormField(
                controller: titleController,
                hint: titleString,
                validator:
                    (value) =>
                        value?.isEmpty ?? false ? mandatoryTitleString : null,
              ),
              DSSpacing.xs.y,
              DSHeadlineSmallText(descriptionString),
              DSTextField(
                controller: descriptionController,
                hint: descriptionString,
                // maxLines: 15,
              ),
              DSSpacing.xs.y,
              DSHeadlineSmallText(categoriesString),
              DSSpacing.xs.y,
              ValueListenableBuilder(
                valueListenable: categoryNotifier,
                builder: (_, value, __) {
                  return DSInputContainer(
                    padding: EdgeInsets.symmetric(
                      horizontal: DSSpacing.xs.value,
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
                      onChanged: (value) => categoryNotifier.value = value!,
                      value: value,
                    ),
                  );
                },
              ),
              DSSpacing.xs.y,
              DSHeadlineSmallText(imagesString),
              ListenableBuilder(
                listenable: viewmodel.updateListImages,
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
                                      viewmodel.removeImage(e.$1);
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
              DSSpacing.xs.y,
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
              DSSpacing.xs.y,
              DSHeadlineSmallText(courseString),
              DSSpacing.xs.y,
              ValueListenableBuilder(
                valueListenable: courseNotifier,
                builder: (_, value, __) {
                  return DSInputContainer(
                    padding: EdgeInsets.symmetric(
                      horizontal: DSSpacing.xs.value,
                    ),
                    child: DropdownButton<CourseHub>(
                      underline: const SizedBox.shrink(),
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(12),
                      icon: Icon(DSIcons.arrow_down_outline.data),
                      items:
                          CourseHub.values 
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: DSBodyText(e.labelCourseHub),
                                ),
                              )
                              .toList(),
                      onChanged: (value) => courseNotifier.value = value!,
                      value: value,
                    ),
                  );
                },
              ),
              DSSpacing.xs.y,
              SizedBox(
                height: DSSpacing.xxxl.value,
                child: DSPrimaryButton(
                  autoSize: false,
                  onPressed: () {
                    if (form.currentState?.validate() ?? false) {
                      viewmodel.createNews.execute(
                        NewsModel(
                          uid: '',
                          title: titleController.text,
                          description: descriptionController.text,
                          categoryNews: categoryNotifier.value,
                          course: courseNotifier.value,
                          publishedAt: DateTime.now(),
                          images: [],
                        ),
                      );
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
