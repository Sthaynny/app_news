import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/extension/build_context.dart';
import 'package:ufersa_hub/core/utils/extension/string.dart';
import 'package:ufersa_hub/core/utils/validators/validators.dart';
import 'package:ufersa_hub/features/documents/domain/models/document_model.dart';
import 'package:ufersa_hub/features/documents/view/maneger/maneger_document_viewmodel.dart';
import 'package:ufersa_hub/features/shared/domain/enums/category_post.dart';

class ManegerDocumentScreen extends StatefulWidget {
  const ManegerDocumentScreen({super.key, required this.viewmodel, this.doc});
  final ManegerDocumentViewmodel viewmodel;
  final DocumentModel? doc;

  @override
  State<ManegerDocumentScreen> createState() => _ManegerDocumentScreenState();
}

class _ManegerDocumentScreenState extends State<ManegerDocumentScreen> {
  late final ManegerDocumentViewmodel viewmodel;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();
  final fileUrlController = TextEditingController();
  final ValueNotifier<CategoryPost> categoryNotifier = ValueNotifier(
    CategoryPost.other,
  );
  DocumentModel? get doc => widget.doc;
  final form = GlobalKey<FormState>();
  var validation = [];

  @override
  void initState() {
    viewmodel = widget.viewmodel;
    viewmodel.manegerDoc.addListener(_onResult);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (doc != null) {
      titleController.text = doc!.name;
      descriptionController.text = doc!.description ?? '';
      linkController.text = doc!.link ?? '';
      fileUrlController.text = doc!.fileUrl ?? '';
      viewmodel.init(doc!);
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ManegerDocumentScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewmodel.manegerDoc.removeListener(_onResult);
    viewmodel.manegerDoc.addListener(_onResult);
  }

  @override
  void dispose() {
    viewmodel.manegerDoc.removeListener(_onResult);
    descriptionController.dispose();
    titleController.dispose();
    linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSHeader(
        title: doc != null ? editEventString : createEventString,
      ),
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
                onError: (p0) => validation.add(p0),
              ),
              DSSpacing.xs.y,
              DSHeadlineSmallText(descriptionString),
              DSTextField(
                controller: descriptionController,
                hint: descriptionString,
                // maxLines: 15,
              ),

              DSSpacing.xs.y,
              DSHeadlineSmallText(documentString),
              ListenableBuilder(
                listenable: viewmodel.updateFile,
                builder: (context, child) {
                  if (viewmodel.docFile == null) return Container();

                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: DSColors.primary.shade800),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: DSCaptionText(archiveAttachedString),
                      trailing: DSIconButton(
                        onPressed: () {
                          viewmodel.removeFile();
                        },
                        icon: DSIcons.trash_outline,
                        color: DSColors.error,
                      ),
                    ),
                  );
                },
              ),
              DSSpacing.xs.y,
              DSCaptionText(worningDocumentLengthString),
              DSSpacing.xs.y,
              ListenableBuilder(
                listenable: viewmodel.updateFile,
                builder: (context, child) {
                  return SizedBox(
                    height: DSSpacing.xxxl.value,
                    child: DSSecondaryButton(
                      autoSize: false,
                      isEnabled: viewmodel.docFile == null,
                      isLoading: viewmodel.updateFile.running,
                      trailingIcon: Icon(
                        DSIcons.add_solid.data,
                        color: DSColors.primary.shade800,
                      ),
                      onPressed: () {
                        viewmodel.addFile();
                      },
                      label: addDocumentString,
                    ),
                  );
                },
              ),
              DSSpacing.xs.y,
              DSHeadlineSmallText(linkForDownloadDocumentString),
              DSTextFormField(
                controller: fileUrlController,
                hint: linkString,
                validator:
                    (value) =>
                        value?.isNotEmpty ?? false
                            ? Validators.validateUrl(value)
                            : null,
                onError: (p0) => validation.add(p0),
                textInputType: TextInputType.url,
                // maxLines: 15,
              ),
              DSSpacing.xs.y,
              DSHeadlineSmallText(linkForMoreInformationString),
              DSTextFormField(
                controller: linkController,
                hint: linkString,
                validator:
                    (value) =>
                        value?.isNotEmpty ?? false
                            ? Validators.validateUrl(value)
                            : null,
                onError: (p0) => validation.add(p0),
                textInputType: TextInputType.url,
                // maxLines: 15,
              ),
              DSSpacing.xs.y,
              SizedBox(
                height: DSSpacing.xxxl.value,
                child: DSPrimaryButton(
                  autoSize: false,
                  onPressed: () {
                    validation.clear();
                    form.currentState?.validate();
                    if (!validation.any((element) => element == true)) {
                      viewmodel.manegerDoc.execute(
                        DocumentModel(
                          uid: '',
                          name: titleController.text,
                          description: descriptionController.text,
                          fileUrl:
                              fileUrlController.text.isEmpty
                                  ? null
                                  : fileUrlController.text.addPreffixHttpsUrl,
                          link:
                              linkController.text.isEmpty
                                  ? null
                                  : linkController.text.addPreffixHttpsUrl,
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
    if (viewmodel.manegerDoc.completed) {
      viewmodel.manegerDoc.clearResult();
      context.back(viewmodel.documentUpdate);
    }

    if (viewmodel.manegerDoc.error) {
      viewmodel.manegerDoc.clearResult();
      context.showSnackBarError(errorDefaultString);
    }
  }
}
