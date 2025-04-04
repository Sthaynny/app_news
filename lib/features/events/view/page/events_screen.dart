import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/events/domain/models/events_model.dart';
import 'package:ufersa_hub/features/events/view/page/events_view_model.dart';
import 'package:ufersa_hub/features/shared/components/news_app_bar.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key, required this.viewModel});

  final EventsViewModel viewModel;

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late final EventsViewModel viewModel;
  @override
  void initState() {
    viewModel = widget.viewModel;
    viewModel.getEvents.execute();
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
          if (widget.viewModel.getEvents.error) {}
          final events =
              widget.viewModel.getEvents.result?.value as List<EventsModel>;

          return SingleChildScrollView(
            padding: EdgeInsets.all(DSSpacing.md.value),
            child: Column(children: events.map((e) => Text(e.title)).toList()),
          );
        },
      ),
    );
  }
}
