import 'package:app_news/core/router/app_router.dart';
import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/core/utils/extension/build_context.dart';
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
  }

  @override
  void didUpdateWidget(covariant CreateNewsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewmodel.createNews.removeListener(_onResult);
    viewmodel.createNews.addListener(_onResult);
  }

  @override
  void dispose() {
    viewmodel.createNews.removeListener(_onResult);
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
          child: Column(
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
              DSTextField(
                controller: descriptionController,
                hint: descriptionString,
                maxLines: 0,
              ),
              DSSpacing.md.y,
              DSHeadlineSmallText(imagesString),
              DSSpacing.md.y,
              ListenableBuilder(
                listenable: viewmodel.manegesImages,
                builder: (context, child) {
                  if (viewmodel.images.isEmpty) {
                    return SizedBox(
                      height: DSSpacing.xxxl.value,
                      child: Expanded(
                        child: DSPrimaryButton(
                          trailingIcon: Icon(DSIcons.add_solid.data),
                          onPressed: () {},
                          label: addImageString,
                        ),
                      ),
                    );
                  }
                  return Wrap();
                },
              ),
              DSSpacing.md.y,
              SizedBox(
                height: DSSpacing.xxxl.value,
                child: Expanded(
                  child: DSPrimaryButton(
                    onPressed: () {
                      if (form.currentState?.validate() ?? false) {
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: DSColors.error.withAlpha(150),
                            content: DSCaptionSmallText(errorDefaultString),
                          ),
                        );
                      }
                    },
                    label: saveString,
                  ),
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: DSCaptionSmallText(errorDefaultString)));
    }
  }
}
