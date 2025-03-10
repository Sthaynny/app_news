import 'dart:io';

import 'package:app_news/core/utils/commands.dart';
import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/shared/news/data/repositories/news_repository.dart';
import 'package:app_news/features/shared/news/domain/models/news_model.dart';

class CreateNewsViewmodel {
  final NewsRepository _repository;

  CreateNewsViewmodel({required NewsRepository repository})
    : _repository = repository {
    createNews = CommandAction<void, NewsModel>(
      (model) => _repository.createNews(model),
    );

    manegesImages = CommandAction<void, (int?, List<File>)>(_manegesImages);
  }

  late final CommandAction<void, NewsModel> createNews;
  late final CommandAction<void, (int?, List<File>)> manegesImages;

  List<File> images = [];

  Future<Result<void>> _manegesImages((int?, List<File>) data) async {
    final (index, images) = data;
    if (index != null) images.removeAt(index);

    images.addAll(images);
    return Result.ok();
  }
}
