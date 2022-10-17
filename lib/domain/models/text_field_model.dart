class TextFieldModel {
  final String key;
  final String value;

  TextFieldModel({required this.key, required this.value});

  factory TextFieldModel.fromJson(String title, String value) =>
      TextFieldModel(key: title, value: value);
}
