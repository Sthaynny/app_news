import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/router/app_router.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/extension/build_context.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/documents/domain/models/document_model.dart';
import 'package:ufersa_hub/features/documents/view/page/components/card_document_widget.dart';
import 'package:ufersa_hub/features/documents/view/page/documents_view_model.dart';
import 'package:ufersa_hub/features/shared/components/body_error_default_widget.dart';
import 'package:ufersa_hub/features/shared/components/button_add_item_widget.dart';
import 'package:ufersa_hub/features/shared/components/news_app_bar.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key, required this.viewmodel});

  final DocumentsViewModel viewmodel;

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  late final DocumentsViewModel viewmodel;
  @override
  void initState() {
    viewmodel = widget.viewmodel;
    viewmodel.getData.execute();
    viewmodel.authenticated.execute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsAppBar(canPop: true, title: eventsString),
      body: ListenableBuilder(
        listenable: widget.viewmodel.getData,
        builder: (context, child) {
          if (widget.viewmodel.getData.running) {
            return Center(child: DSSpinnerLoading());
          }
          if (widget.viewmodel.getData.error) {
            return BodyErrorDefaultWidget(
              title: opsErrorLoadingEventsString,
              onPressed: () => viewmodel.getData.execute(),
            );
          }
          final events = viewmodel.getData.result?.value as List<DocumentModel>;
          if (events.isEmpty) {
            return Center(
              child: DSHeadlineSmallText(noEventString, maxLines: 4),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              viewmodel.getData.clearResult();
              viewmodel.getData.execute();
            },
            child: ListView(
              padding: EdgeInsets.all(DSSpacing.md.value),
              children:
                  events
                      .map(
                        (e) => CardDocumentWidget(
                          doc: e,
                          updateScreen: () {
                            viewmodel.getData.execute();
                          },
                          saveFile: (String value) {
                            viewmodel.saveFile.execute(value);
                          },
                        ),
                      )
                      .toList(),
            ),
          );
        },
      ),
      floatingActionButton: ListenableBuilder(
        listenable: viewmodel.authenticated,
        builder:
            (context, child) => ButtonAddItemWidget(
              label: addEventString,
              onPressed: () async {
                final result = await context.go(AppRouters.manegerEvents);
                if (result != null) {
                  viewmodel.getData.execute();
                }
              },
              isVisible: viewmodel.userAuthenticated,
            ),
      ),
    );
  }
}
