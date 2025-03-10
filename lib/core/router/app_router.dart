import 'package:app_news/core/dependecy/dependency.dart';
import 'package:app_news/features/home/screen/home_screen.dart';
import 'package:app_news/features/home/screen/home_view_model.dart';
import 'package:app_news/features/login/screen/login_screen.dart';
import 'package:app_news/features/news/args/news_args.dart';
import 'package:app_news/features/news/details/screen/details_image_screen.dart';
import 'package:app_news/features/news/details/screen/details_news_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  AppRouters.home.path:
      (context) => HomeScreen(
        viewmodel: HomeViewModel(
          authRepository: dependency(),
          newsRepository: dependency(),
        ),
      ),
  AppRouters.login.path: (context) => LoginScreen(viewmodel: dependency()),
  AppRouters.detailsNews.path:
      (context) => DetailsNewsScreen(
        args: ModalRoute.of(context)?.settings.arguments as NewsArgs,
      ),
  AppRouters.detailsNewsImage.path:
      (context) => DetailsImageScreen(
        heroImage: ModalRoute.of(context)?.settings.arguments as Widget,
      ),
};

enum AppRouters {
  login,
  home,
  detailsNews,
  detailsNewsImage;

  const AppRouters();
  String get path => this == home ? '/' : '/$name';
}
