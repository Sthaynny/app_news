import 'package:app_news/core/dependecy/dependency.dart';
import 'package:app_news/features/home/screen/home_screen.dart';
import 'package:app_news/features/home/screen/home_view_model.dart';
import 'package:app_news/features/login/screen/login_screen.dart';
import 'package:app_news/features/news/details/screen/details_news_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: AppRouters.home.path,
      builder:
          (context, state) => HomeScreen(
            viewmodel: HomeViewModel(
              authRepository: dependency(),
              newsRepository: dependency(),
            ),
          ),
      routes: [
        GoRoute(
          path: AppRouters.detailsNews.path,
          name: AppRouters.detailsNews.name,
          builder: (context, state) => DetailsNewsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: AppRouters.login.path,
      builder: (context, state) => LoginScreen(viewmodel: dependency()),
    ),
  ],
);

enum AppRouters {
  login,
  home,
  detailsNews;

  const AppRouters();
  String get path => this == home ? '/' : '/$name';
}
