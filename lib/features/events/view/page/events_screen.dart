import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/router/app_router.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/extension/build_context.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/events/domain/models/events_model.dart';
import 'package:ufersa_hub/features/events/view/page/components/card_event_widget.dart';
import 'package:ufersa_hub/features/events/view/page/events_view_model.dart';
import 'package:ufersa_hub/features/shared/components/body_error_default_widget.dart';
import 'package:ufersa_hub/features/shared/components/button_add_item_widget.dart';
import 'package:ufersa_hub/features/shared/components/news_app_bar.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key, required this.viewModel});

  final EventsViewModel viewModel;

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late final EventsViewModel viewmodel;
  @override
  void initState() {
    viewmodel = widget.viewModel;
    viewmodel.getEvents.execute();
    viewmodel.authenticated.execute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsAppBar(canPop: true, title: eventsString),
      body: ListenableBuilder(
        listenable: widget.viewModel.getEvents,
        builder: (context, child) {
          if (widget.viewModel.getEvents.running) {
            return Center(child: DSSpinnerLoading());
          }
          if (widget.viewModel.getEvents.error) {
            return BodyErrorDefaultWidget(
              title: opsErrorLoadingEventsString,
              onPressed: () => viewmodel.getEvents.execute(),
            );
          }
          final events = viewmodel.getEvents.result?.value as List<EventsModel>;
          if (events.isEmpty) {
            return Center(
              child: DSHeadlineSmallText(noEventString, maxLines: 4),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              viewmodel.getEvents.clearResult();
              viewmodel.getEvents.execute();
            },
            child: ListView(
              padding: EdgeInsets.all(DSSpacing.md.value),
              children:
                  events
                      .map(
                        (e) => CardEventWidget(
                          event: e,
                          updateScreen: () {
                            viewmodel.getEvents.execute();
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
                  viewmodel.getEvents.execute();
                }
              },
              isVisible: viewmodel.userAuthenticated,
            ),
      ),
    );
  }
}
