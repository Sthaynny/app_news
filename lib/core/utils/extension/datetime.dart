extension DatetimeExt on DateTime {
  String get toPublishedAt {
    final String day = this.day.toString().padLeft(2, '0');
    final String month = this.month.toString().padLeft(2, '0');
    final String year = this.year.toString();
    final String hour = this.hour.toString().padLeft(2, '0');
    final String minute = this.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }

  String get toDateAt {
    final String day = this.day.toString().padLeft(2, '0');
    final String month = this.month.toString().padLeft(2, '0');
    final String year = this.year.toString();
    return '$day/$month/$year';
  }

  String get toFormatPtBr => "$day/$month/$year";
}
