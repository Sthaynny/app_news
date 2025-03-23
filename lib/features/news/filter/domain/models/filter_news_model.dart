import 'package:app_news/features/shared/news/domain/enums/category_news.dart';

class FilterNewsModel {
  final String? title;
  final List<CategoryNews> categories;

  const FilterNewsModel({this.categories = const [], this.title});

  FilterNewsModel copyWith({String? title, List<CategoryNews>? categories}) {
    return FilterNewsModel(
      title: title ?? this.title,
      categories: categories ?? this.categories,
    );
  }
}
