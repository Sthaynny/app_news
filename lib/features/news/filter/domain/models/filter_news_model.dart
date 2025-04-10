// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ufersa_hub/features/shared/domain/enums/category_post.dart';
import 'package:ufersa_hub/features/shared/domain/enums/course_hub.dart';

class FilterNewsModel {
  final String? title;
  final List<CategoryPost> categories;
  final List<CourseHub> course;

  const FilterNewsModel({
    this.categories = const [],
    this.title,
    this.course = const [],
  });

  FilterNewsModel copyWith({
    String? title,
    List<CategoryPost>? categories,
    List<CourseHub>? course,
  }) {
    return FilterNewsModel(
      title: title ?? this.title,
      categories: categories ?? this.categories,
      course: course ?? this.course,
    );
  }
}
