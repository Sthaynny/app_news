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
  final VoidCallback saveFile;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: DSHeadlineSmallText(doc.name, maxLines: 3),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (doc.description != null)
              Padding(
                padding: EdgeInsets.only(bottom: DSSpacing.xs.value),
                child: DSBodyText(doc.description, maxLines: 2),
              ),
            if (doc.link != null)
              DSCaptionText.rich(
                TextSpan(
                  text: '${linkForDocumentationString.addSuffixColon} ',
                  children: DSLinkify.plainText(text: doc.link!),
                ),

                fontWeight: FontWeight.bold,
                maxLines: 2,
              ),
          ],
        ),
        trailing:
            doc.base64 != null || doc.fileUrl != null
                ? DSIconButton(
                  onPressed: saveFile,
                  icon: DSIcons.download_outline,
                )
                : null,
      ),
    );
  }
}
