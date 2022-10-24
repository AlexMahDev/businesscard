class InputPatternUI {
  String? getInputPattern(String key) {
    if (key == 'phoneNumber') {
      return r'[+0-9]';
    } else {
      return null;
    }
  }
}
