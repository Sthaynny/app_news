import 'package:app_news/core/dependecy/dependency.dart';
import 'package:app_news/features/home/screen/home_screen.dart';
import 'package:app_news/features/home/screen/home_view_model.dart';
import 'package:app_news/features/login/screen/login_screen.dart';
import 'package:app_news/features/news/args/news_args.dart';
import 'package:app_news/features/news/details/screen/details_image_screen.dart';
import 'package:app_news/features/news/details/screen/details_news_screen.dart';
import 'package:app_news/features/news/details/screen/details_news_viewmodel.dart';
import 'package:app_news/features/news/maneger/maneger_news_screen.dart';
import 'package:app_news/features/news/maneger/maneger_news_viewmodel.dart';
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
  AppRouters.detailsNews.path: (context) {
    final args = ModalRoute.of(context)?.settings.arguments as NewsArgs;
    return DetailsNewsScreen(
      viewmodel: DetailsNewsViewmodel(
        news: args.news,
        isAuthenticated: args.isAuthenticated,
        repository: dependency(),
      ),
    );
  },
  AppRouters.detailsNewsImage.path:
      (context) => DetailsImageScreen(
        heroImage: ModalRoute.of(context)?.settings.arguments as Widget,
      ),
  AppRouters.manegerNews.path:
      (context) => CreateNewsScreen(
        viewmodel: ManegerNewsViewmodel(
          repository: dependency(),
          permissionService: dependency(),
        ),
      ),
};

enum AppRouters {
  login,
  home,
  detailsNews,
  detailsNewsImage,
  manegerNews;

  const AppRouters();
  String get path => this == home ? '/' : '/$name';
}
