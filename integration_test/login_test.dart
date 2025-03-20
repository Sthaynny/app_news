import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/features/home/screen/components/card_news_widget.dart';
import 'package:app_news/main.dart' as app;
import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol_finders/patrol_finders.dart';

import 'utils/waits_fuctions.dart';

void main() {
  patrolWidgetTest('open login screen', ($) async {
    // Replace later with your app's main widget

    debugPrint('testLoginInteraction: iniciando');
    final tester = $.tester;
    app.main();

    await waitFor(
      tester,
      find.byWidgetPredicate((widget) => widget is CardNewsWidget),
    );

    await testLoginInteraction($);
  });
}

Future<void> testLoginInteraction(
  PatrolTester $, {
  bool goToLogin = true,
}) async {
  if (goToLogin) {
    final icon = find.byWidgetPredicate(
      (widget) => widget is DSHeadlineSmallText && widget.text == appNameString,
    );

    await $.longPress(icon);
    await $.pumpAndSettle();
  }
  debugPrint('testLoginInteraction: logar');
  final emailField = find.byWidgetPredicate(
    (widget) => widget is DSTextFormField && widget.hint == emailString,
  );
  final passwordField = find.byWidgetPredicate(
    (widget) => widget is DSTextFormField && widget.hint == passwordString,
  );

  debugPrint('testLoginInteraction: add information');
  await $(emailField).enterText('test@t.com');
  await $(passwordField).enterText('123456');

  await $(find.byWidgetPredicate((widget) => widget is DSButton)).tap();
  await $.pumpAndSettle();

  debugPrint('testLoginInteraction: logando');
  await waitFor(
    $.tester,
    find.byWidgetPredicate((widget) => widget is CardNewsWidget),
  );
}
