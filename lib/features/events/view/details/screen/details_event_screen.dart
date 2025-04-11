import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/router/app_router.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/extension/build_context.dart';
import 'package:ufersa_hub/core/utils/extension/string.dart';
import 'package:ufersa_hub/features/events/view/details/screen/details_event_view_model.dart';
import 'package:ufersa_hub/features/shared/components/category_tile.dart';
import 'package:ufersa_hub/features/shared/components/image_widget.dart';

class DetailsEventScreen extends StatefulWidget {
  const DetailsEventScreen({super.key, required this.viewmodel});
  final DetailsEventViewmodel viewmodel;

  @override
  State<DetailsEventScreen> createState() => _DetailsEventScreenState();
}

class _DetailsEventScreenState extends State<DetailsEventScreen> {
  late final DetailsEventViewmodel viewmodel;
  @override
  void initState() {
    viewmodel = widget.viewmodel;
    viewmodel.deleteEvent.addListener(_onResultDelete);
    viewmodel.authenticated.execute();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DetailsEventScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewmodel.deleteEvent.removeListener(_onResultDelete);
    viewmodel.deleteEvent.addListener(_onResultDelete);
  }

  @override
  void dispose() {
    viewmodel.deleteEvent.removeListener(_onResultDelete);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSHeader(
        title: detailsEventString,
        canPop: true,
        actions: [
          ListenableBuilder(
            listenable: viewmodel.authenticated,
            builder:
                (context, child) =>
                    viewmodel.isAuthenticated
                        ? DSIconButton(
                          key: Key('edit_button'),
                          onPressed: () async {
                            final result = await context.go(
                              AppRouters.manegerEvents,
                              arguments: viewmodel.event,
                            );
                            if (result != null) {
                              viewmodel.updateScreen.execute(result);
                            }
                          },
                          icon: DSIcons.edit_outline,
                          color: DSColors.primary.shade600,
                        )
                        : SizedBox(),
          ),

          ListenableBuilder(
            listenable: viewmodel.authenticated,
            builder:
                (context, child) =>
                    viewmodel.isAuthenticated
                        ? DSIconButton(
                          key: Key('delete_button'),
                          onPressed: () {
                            viewmodel.deleteEvent.execute(viewmodel.event.uid);
                          },
                          icon: DSIcons.trash_outline,
                          color: DSColors.error,
                        )
                        : SizedBox(),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.viewmodel.updateScreen,
        builder: (context, _) {
          return ListView(
            padding: EdgeInsets.all(DSSpacing.md.value),
            children: [
              if (viewmodel.imagesBase64 != null)
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 250,
                    maxWidth: MediaQuery.of(context).size.width - 16,
                  ),
                  child: ImageWidget(
                    imageBase64: viewmodel.imagesBase64!,
                    fit: BoxFit.fill,
                  ),
                ),
              DSSpacing.xs.y,
              DSHeadlineLargeText(viewmodel.event.title),
              DSBodyText(
                viewmodel.event.description,
                overflow: null,
                textAlign: TextAlign.justify,
              ),
              DSSpacing.xs.y,
              ChipTile(label: viewmodel.event.category.labelPtBr),
              DSSpacing.xs.y,
              DSCaptionText.rich(
                TextSpan(
                  text: '${dateEventString.addSuffixColon} ',
                  children: <TextSpan>[
                    TextSpan(
                      text: viewmodel.event.toDateEvent,
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),

                fontWeight: FontWeight.bold,
              ),

              if (viewmodel.event.location != null)
                Padding(
                  padding: EdgeInsets.only(top: DSSpacing.xs.value),
                  child: DSSecondaryButton(
                    onPressed: () {
                      viewmodel.event.location?.goToUrl();
                    },
                    label: 'Acessar Localização',
                    borderColor: DSColors.error,
                    foregroundColor: DSColors.error,
                    leadingIcon: Icon(
                      DSIcons.localization_outline.data,
                      color: DSColors.error,
                    ),
                    contentAlignment: MainAxisAlignment.start,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _onResultDelete() {
    if (viewmodel.deleteEvent.completed) {
      context.back(true);
    }
    if (viewmodel.deleteEvent.error) {
      context.showSnackBarError(errorDeleteString);
    }
  }
}
