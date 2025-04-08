import 'package:ufersa_hub/core/utils/commands.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/news/filter/domain/models/filter_news_model.dart';
import 'package:ufersa_hub/features/shared/news/domain/enums/category_post.dart';

class FilterViewModel {
  FilterViewModel({FilterNewsModel? filter}) {
    this.filter = filter ?? FilterNewsModel();
    filterNews = CommandAction((filter) async {
      this.filter = filter;
      return Result.ok();
    });
  }

  late FilterNewsModel filter;
  late CommandAction<void, FilterNewsModel> filterNews;

  void addCateroryFilter(CategoryPost category) {
    var categories = [...filter.categories];
    if (filter.categories.contains(category)) {
      categories.remove(category);
      filter = filter.copyWith(categories: categories..remove(category));
    } else {
      categories.add(category);
      filter = filter.copyWith(categories: categories);
    }
    filterNews.execute(filter);
  }
}
