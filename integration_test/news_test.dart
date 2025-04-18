import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol_finders/patrol_finders.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/features/app.dart';
import 'package:ufersa_hub/features/home/screen/components/card_news_widget.dart';
import 'package:ufersa_hub/features/home/utils/home_strings.dart';
import 'package:ufersa_hub/main.dart' as app;

import 'login_test.dart';
import 'utils/waits_fuctions.dart';

void main() {
  final titleTest = 'Teste de integração';
  patrolWidgetTest('Create news', ($) async {
    // Replace later with your app's main widget

    debugPrint('testNewsInteraction: iniciando');
    final tester = $.tester;
    app.main();

    await waitFor(
      tester,
      find.byWidgetPredicate((widget) => widget is CardNewsWidget),
    );

    debugPrint('testNewsInteraction: logando app');

    await testLoginInteraction($);

    await testCreateNewsInteraction($);
  });
  patrolWidgetTest('Edit news', ($) async {
    // Replace later with your app's main widget

    debugPrint('testEditInteraction: iniciando');

    await $.pumpWidgetAndSettle(MyApp());
    await waitFor(
      $.tester,
      find.byWidgetPredicate((widget) => widget is CardNewsWidget),
    );

    debugPrint('testEditInteraction: logando app');

    debugPrint('testEditInteraction: acessando detalhes news');
    final cardNews = find.byWidgetPredicate(
      (widget) => widget is CardNewsWidget && widget.news.title == titleTest,
    );

    await $(cardNews).tap();

    await $.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is DSHeader && widget.title == detailsNewsString,
      ),
      findsOneWidget,
    );
    expect(find.byType(DSText), findsWidgets);

    debugPrint('testEditInteraction: acessando tela de edição');

    final editButton = find.byKey(Key('edit_button'));

    expect(editButton, findsOneWidget);

    await $(editButton).tap();

    await $.pumpAndSettle();

    debugPrint('testEditInteraction: editando descrição');

    final description = find.byType(DSTextField).at(0);
    final textDescription = 'Teste de integração descrição editada';
    await $(description).enterText(textDescription);

    final saveButton = find.byWidgetPredicate(
      (widget) => widget is DSPrimaryButton && widget.label == saveString,
    );

    await $(saveButton).tap();

    await waitFor(
      $.tester,
      find.byWidgetPredicate((widget) => widget is CardNewsWidget),
    );

    debugPrint('testEditInteraction: validando descrição editada');

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is CardNewsWidget &&
            widget.news.description == textDescription,
      ),
      findsOneWidget,
    );
  });
  patrolWidgetTest('Delete news', ($) async {
    // Replace later with your app's main widget

    debugPrint('testDeleteInteraction: iniciando');

    await $.pumpWidgetAndSettle(MyApp());

    await waitFor(
      $.tester,
      find.byWidgetPredicate((widget) => widget is CardNewsWidget),
    );

    debugPrint('testDeleteInteraction: logando app');

    debugPrint('testDeleteInteraction: acessando detalhes news');
    final cardNews = find.byWidgetPredicate(
      (widget) => widget is CardNewsWidget && widget.news.title == titleTest,
    );

    await $(cardNews).tap();

    await $.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is DSHeader && widget.title == detailsNewsString,
      ),
      findsOneWidget,
    );
    expect(find.byType(DSText), findsWidgets);

    debugPrint('testDeleteInteraction: acessando tela de edição');

    final deleteButton = find.byKey(Key('delete_button'));

    expect(deleteButton, findsOneWidget);

    await $(deleteButton).tap();

    await $.pumpAndSettle();

    debugPrint('testDeleteInteraction: voltando para home');

    await waitFor(
      $.tester,
      find.byWidgetPredicate((widget) => widget is CardNewsWidget),
    );

    debugPrint('testDeleteInteraction: validando card removido');

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is CardNewsWidget && widget.news.description == titleTest,
      ),
      findsNothing,
    );
  });
}

Future<void> testCreateNewsInteraction(
  PatrolTester $, {
  String? titleString,
}) async {
  debugPrint('testNewsInteraction: criando noticia');
  final createNewsButton = find.byWidgetPredicate(
    (widget) =>
        widget is DSPrimaryButton && widget.label == HomeStrings.addNews.label,
  );
  await $(createNewsButton).tap();
  await $.pumpAndSettle();

  expect(find.byType(DSTextFormField), findsOneWidget);
  expect(find.byType(DSTextField), findsOneWidget);

  final title = find.byType(DSTextFormField).at(0);
  final description = find.byType(DSTextField).at(0);

  await $(title).enterText(titleString ?? 'Teste de integração');
  await $(description).enterText('Teste de integração descrição');

  final createButton = find.byWidgetPredicate(
    (widget) => widget is DSPrimaryButton && widget.label == saveString,
  );
  debugPrint('testNewsInteraction: mandando criar noticia');

  await $(createButton).tap();

  await waitFor(
    $.tester,
    find.byWidgetPredicate((widget) => widget is CardNewsWidget),
  );

  debugPrint('testNewsInteraction: go to home');
}
