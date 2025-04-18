import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/extension/string.dart';
import 'package:ufersa_hub/features/documents/domain/models/document_model.dart';

class CardDocumentWidget extends StatelessWidget {
  const CardDocumentWidget({
    super.key,
    required this.doc,
    required this.updateScreen,
    required this.saveFile,
  });
  final DocumentModel doc;
  final VoidCallback updateScreen;
  final ValueChanged<String> saveFile;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          // final result = await context.go(
          //   AppRouters.detailsEvent,
          //   arguments: doc,
          // );
          // if (result != null) {
          //   updateScreen();
          // }
        },

        title: DSHeadlineSmallText(doc.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (doc.description != null)
              Padding(
                padding: EdgeInsets.only(bottom: DSSpacing.xs.value),
                child: DSBodyText(doc.description, maxLines: 2),
              ),
            if (doc.url != null)
              DSCaptionText.rich(
                TextSpan(
                  text: '${linkForDocumentationString.addSuffixColon} ',
                  children: DSLinkify.plainText(text: doc.url!),
                ),

                fontWeight: FontWeight.bold,
                maxLines: 2,
              ),
          ],
        ),
        trailing: DSIconButton(
          onPressed: () {
            saveFile(doc.base64!);
          },
          icon: DSIcons.download_outline,
        ),
      ),
    );
  }
}
