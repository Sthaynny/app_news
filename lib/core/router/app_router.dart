import 'package:flutter/widgets.dart';
import 'package:ufersa_hub/core/dependecy/dependency.dart';
import 'package:ufersa_hub/features/events/view/details/screen/details_event_screen.dart';
import 'package:ufersa_hub/features/events/view/maneger/maneger_events_screen.dart';
import 'package:ufersa_hub/features/events/view/page/events_screen.dart';
import 'package:ufersa_hub/features/home/screen/home_screen.dart';
import 'package:ufersa_hub/features/home/screen/home_view_model.dart';
import 'package:ufersa_hub/features/login/screen/login_screen.dart';
import 'package:ufersa_hub/features/news/args/news_args.dart';
import 'package:ufersa_hub/features/news/details/screen/details_image_screen.dart';
import 'package:ufersa_hub/features/news/details/screen/details_news_screen.dart';
import 'package:ufersa_hub/features/news/details/screen/details_news_viewmodel.dart';
import 'package:ufersa_hub/features/news/maneger/maneger_news_screen.dart';
import 'package:ufersa_hub/features/news/maneger/maneger_news_viewmodel.dart';
import 'package:ufersa_hub/features/shared/news/domain/models/news_model.dart';

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
        news: ModalRoute.of(context)?.settings.arguments as NewsModel?,
      ),

  AppRouters.events.path: (context) => EventsScreen(viewModel: dependency()),
  AppRouters.detailsEvent.path:
      (context) => DetailsEventScreen(viewmodel: dependency()),

      AppRouters.manegerEvents.path:
      (context) => ManegerEventsScreen(viewmodel: dependency()),
};

enum AppRouters {
  login,
  home,
  detailsNews,
  detailsNewsImage,
  manegerNews,
  events,
  detailsEvent,
  manegerEvents;

  const AppRouters();
  String get path => this == home ? '/' : '/$name';
}
