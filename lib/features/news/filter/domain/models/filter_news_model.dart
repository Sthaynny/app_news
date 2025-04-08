import 'package:ufersa_hub/features/shared/news/domain/enums/category_post.dart';

class FilterNewsModel {
  final String? title;
  final List<CategoryPost> categories;

  const FilterNewsModel({this.categories = const [], this.title});

  FilterNewsModel copyWith({String? title, List<CategoryPost>? categories}) {
    return FilterNewsModel(
      title: title ?? this.title,
      categories: categories ?? this.categories,
    );
  }
}
