import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/extension/bool.dart';
import 'package:ufersa_hub/core/utils/extension/build_context.dart';
import 'package:ufersa_hub/core/utils/extension/datetime.dart';
import 'package:ufersa_hub/core/utils/extension/string.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/core/utils/validators/validators.dart';
import 'package:ufersa_hub/features/events/domain/models/events_model.dart';
import 'package:ufersa_hub/features/events/view/maneger/maneger_events_view_model.dart';
import 'package:ufersa_hub/features/shared/models/location_model.dart';
import 'package:ufersa_hub/features/shared/news/domain/enums/category_post.dart';

class ManegerEventsScreen extends StatefulWidget {
  const ManegerEventsScreen({super.key, required this.viewmodel, this.event});
  final ManegerEventsViewmodel viewmodel;
  final EventsModel? event;

  @override
  State<ManegerEventsScreen> createState() => _ManegerEventsScreenState();
}

class _ManegerEventsScreenState extends State<ManegerEventsScreen> {
  late final ManegerEventsViewmodel viewmodel;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final localizationController = TextEditingController();
  final ValueNotifier<CategoryPost> categoryNotifier = ValueNotifier(
    CategoryPost.other,
  );
  EventsModel? get event => widget.event;
  final form = GlobalKey<FormState>();

  @override
  void initState() {
    viewmodel = widget.viewmodel;
    viewmodel.manegerEvent.addListener(_onResult);
    viewmodel.getPermission.addListener(_onResultPermission);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (event != null) {
      titleController.text = event!.title;
      descriptionController.text = event!.description ?? '';
      categoryNotifier.value = event!.category;
      startDateController.text = event!.start.toDateAt;
      endDateController.text = event!.end?.toDateAt ?? '';
      localizationController.text = event?.location?.toLocalizationString ?? '';
      viewmodel.init(event!);
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ManegerEventsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewmodel.manegerEvent.removeListener(_onResult);
    viewmodel.manegerEvent.addListener(_onResult);
    oldWidget.viewmodel.getPermission.removeListener(_onResultPermission);
    viewmodel.getPermission.addListener(_onResultPermission);
  }

  @override
  void dispose() {
    viewmodel.manegerEvent.removeListener(_onResult);
    viewmodel.getPermission.removeListener(_onResultPermission);
    descriptionController.dispose();
    titleController.dispose();
    categoryNotifier.dispose();
    startDateController.dispose();
    endDateController.dispose();
    localizationController.dispose();
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
              DSHeadlineSmallText(categoryString),
              DSSpacing.xs.y,
              ValueListenableBuilder(
                valueListenable: categoryNotifier,
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
                              .where((e) => e != CategoryPost.all)
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
                listenable: viewmodel.updateImage,
                builder: (context, child) {
                  if (viewmodel.image == null) return Container();

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
                          viewmodel.removeImage();
                        },
                        icon: DSIcons.trash_outline,
                        color: DSColors.error,
                      ),
                    ),
                  );
                },
              ),
              DSSpacing.xs.y,

              ListenableBuilder(
                listenable: viewmodel.updateImage,
                builder: (context, child) {
                  return SizedBox(
                    height: DSSpacing.xxxl.value,
                    child: DSSecondaryButton(
                      autoSize: false,
                      isEnabled: viewmodel.image == null,
                      isLoading: viewmodel.updateImage.running,
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
              DSHeadlineSmallText(dateStartEventString),
              DSSpacing.xs.y,
              GestureDetector(
                onTap:
                    () => _selectDate(context, (date) {
                      if (date != null &&
                          date != viewmodel.startDateEventSelected) {
                        viewmodel.startDate.execute(date);
                        startDateController.text = date.formatDateToPtBr;
                      }
                    }),
                child: ListenableBuilder(
                  listenable: viewmodel.startDate,
                  builder:
                      (context, child) => AbsorbPointer(
                        child: DSTextFormField(
                          controller: startDateController,
                          hint: enterWithDateString,
                          validator:
                              (value) =>
                                  value?.isEmpty ?? false
                                      ? startDateIsMandatoryString
                                      : null,
                        ),
                      ),
                ),
              ),
              DSSpacing.xs.y,
              DSHeadlineSmallText(endDateEventString),
              DSSpacing.xs.y,
              GestureDetector(
                onTap:
                    () => _selectDate(context, (date) {
                      if (date != null && date != viewmodel.endDateSelected) {
                        viewmodel.endDate.execute(date);
                        endDateController.text = date.formatDateToPtBr;
                      }
                    }, firstDate: viewmodel.startDateEventSelected),
                child: ListenableBuilder(
                  listenable: viewmodel.endDate,
                  builder:
                      (context, child) => AbsorbPointer(
                        child: DSTextFormField(
                          controller: endDateController,
                          hint: enterWithDateString,
                        ),
                      ),
                ),
              ),
              DSSpacing.xs.y,
              DSHeadlineSmallText(localizationOpionalString),
              DSSpacing.xs.y,
              DSTextFormField(
                controller: localizationController,
                hint: localizationString,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return Validators.validateLocalization(value);
                  }

                  return null;
                },
              ),
              DSSpacing.xxxs.y,
              DSCaptionText(detailsEnterLocalizationString, maxLines: 5),
              DSSpacing.xs.y,
              SizedBox(
                height: DSSpacing.xxxl.value,
                child: DSPrimaryButton(
                  autoSize: false,
                  onPressed: () {
                    if (form.currentState?.validate() ?? false) {
                      LocationModel? location;
                      if (localizationController.text.isNotEmpty) {
                        final (lat, log) =
                            localizationController.text.getLocalizationString;
                        location = LocationModel(latitude: lat, longitude: log);
                      }
                      viewmodel.manegerEvent.execute(
                        EventsModel(
                          uid: '',
                          title: titleController.text,
                          description: descriptionController.text,
                          category: categoryNotifier.value,
                          location: location,
                          start: DateTime.now(),
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
    if (viewmodel.manegerEvent.completed) {
      viewmodel.manegerEvent.clearResult();
      context.back(viewmodel.eventUpdate);
    }

    if (viewmodel.manegerEvent.error) {
      viewmodel.manegerEvent.clearResult();
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

  Future<void> _selectDate(
    BuildContext context,
    void Function(DateTime? date) actionDate, {
    DateTime? firstDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: firstDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime.now(),
      lastDate: DateTime(2101),
    );

    actionDate(picked);
  }
}
