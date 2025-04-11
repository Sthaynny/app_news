enum CategoryPost {
  business,
  entertainment,
  general,
  health,
  science,
  sports,
  technology,
  engeneering,
  architecture,
  processSelection,
  other;

  const CategoryPost();

  String get labelPtBr {
    switch (this) {
      case CategoryPost.business:
        return 'Negócios';
      case CategoryPost.processSelection:
        return 'Processo Seletivo';
      case CategoryPost.entertainment:
        return 'Entretenimento';
      case CategoryPost.general:
        return 'Geral';
      case CategoryPost.health:
        return 'Saúde';
      case CategoryPost.science:
        return 'Ciência';
      case CategoryPost.sports:
        return 'Esportes';
      case CategoryPost.technology:
        return 'Tecnologia';
      case CategoryPost.engeneering:
        return 'Engenharia';
      case CategoryPost.architecture:
        return 'Arquitetura';
      case CategoryPost.other:
        return 'Outros';
    }
  }
}
