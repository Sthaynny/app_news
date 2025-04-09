import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/router/app_router.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/extension/build_context.dart';
import 'package:ufersa_hub/core/utils/extension/string.dart';
import 'package:ufersa_hub/features/events/domain/models/events_model.dart';
import 'package:ufersa_hub/features/shared/components/image_widget.dart';

class CardEventWidget extends StatelessWidget {
  const CardEventWidget({
    super.key,
    required this.event,
    required this.updateScreen,
  });
  final EventsModel event;
  final VoidCallback updateScreen;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          final result = await context.go(
            AppRouters.detailsEvent,
            arguments: event,
          );
          if (result != null) {
            updateScreen();
          }
        },
        leading:
            event.image != null
                ? SizedBox(
                  height: 50,
                  width: 50,
                  child: ImageWidget(imageBase64: event.image!, height: 50),
                )
                : null,
        title: DSHeadlineSmallText(event.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (event.description != null)
              Padding(
                padding: EdgeInsets.only(bottom: DSSpacing.xs.value),
                child: DSBodyText(event.description, maxLines: 2),
              ),
            DSCaptionText.rich(
              TextSpan(
                text: '${dateEventString.addSuffixColon} ',
                children: <TextSpan>[
                  TextSpan(
                    text: event.toDateEvent,
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),

              fontWeight: FontWeight.bold,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
