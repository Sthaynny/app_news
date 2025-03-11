extension ObjectExt on bool? {
  bool get isTrue => this != null && this == true;
  bool get isFalse => !isTrue;
}
