enum CourseHub {
  softwareEngineering,
  computerEngineering,
  environmentalEngineering,
  civilEngineering,
  tecnologyInformation,
  cienceTechnology;

  const CourseHub();

  String get labelCourseHub {
    switch (this) {
      case CourseHub.softwareEngineering:
        return 'Engenharia de Software';
      case CourseHub.computerEngineering:
        return 'Engenharia de Computação';
      case CourseHub.environmentalEngineering:
        return 'Engenharia Ambiental';
      case CourseHub.civilEngineering:
        return 'Engenharia Civil';
      case CourseHub.tecnologyInformation:
        return 'Tecnologia da Informação';
      case CourseHub.cienceTechnology:
        return 'Ciência e Tecnologia';
    }
  }
}
