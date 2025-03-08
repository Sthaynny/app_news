import 'package:app_news/core/router/app_router.dart';
import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  Future<Type?> go<Type>(AppRouters routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed<Type>(routeName.path, arguments: arguments);
  }

  void back([Object? result]) => Navigator.of(this).pop(result);
}
