import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

Future<void> waitFor(
  WidgetTester tester,
  Finder finder, {
  bool isSync = true,
}) async {
  do {
    if (isSync) {
      await tester.pumpAndSettle();
    } else {
      await tester.pump();
    }
    await Future<dynamic>.delayed(const Duration(milliseconds: 100));
  } while (finder.evaluate().isEmpty);
}

Future<void> waitForDuration(WidgetTester tester, Duration duration) async {
  var timerDone = false;

  Timer(duration, () => timerDone = true);

  while (!timerDone) {
    await tester.pump();
  }
}
