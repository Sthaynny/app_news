enum CategoryNews {
  all,
  business,
  entertainment,
  general,
  health,
  science,
  sports,
  technology,
  engeneering,
  architecture,
  other;

  const CategoryNews();

  String get labelPtBr {
    switch (this) {
      case CategoryNews.all:
        return 'Todas';
      case CategoryNews.business:
        return 'Negócios';
      case CategoryNews.entertainment:
        return 'Entretenimento';
      case CategoryNews.general:
        return 'Geral';
      case CategoryNews.health:
        return 'Saúde';
      case CategoryNews.science:
        return 'Ciência';
      case CategoryNews.sports:
        return 'Esportes';
      case CategoryNews.technology:
        return 'Tecnologia';
      case CategoryNews.engeneering:
        return 'Engenharia';
      case CategoryNews.architecture:
        return 'Arquitetura';
      case CategoryNews.other:
        return 'Outros';
    }
  }
}
