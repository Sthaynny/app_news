import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/features/home/screen/components/card_news_widget.dart';
import 'package:ufersa_hub/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'utils/waits_fuctions.dart';

void main() {
  patrolWidgetTest('open home screen', ($) async {
    // Replace later with your app's main widget
    final tester = $.tester;
    app.main();

    await waitFor(
      tester,
      find.byWidgetPredicate((widget) => widget is CardNewsWidget),
    );

    final icon = find.byKey(Key('menu_button'));
    expect(icon, findsOneWidget);

    await $.tap(icon);
    await $.pumpAndSettle();

    expect(find.text(menuString), findsOneWidget);
  });
}
