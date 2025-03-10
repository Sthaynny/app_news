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

    addImages = CommandAction<void, List<File>>(_addImages);
    removeImage = CommandAction<void, int>((index) async {
      images.removeAt(index);
      return Result.ok();
    });
  }

  late final CommandAction<void, NewsModel> createNews;
  late final CommandAction<void, List<File>> addImages;
  late final CommandAction<void, int> removeImage;

  List<File> images = [];

  Future<Result<void>> _addImages(List<File> images) async {
    images.addAll(images);
    return Result.ok();
  }
}
