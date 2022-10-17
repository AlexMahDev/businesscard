import 'package:businesscard/domain/models/text_field_model.dart';

class ExtraInfoModel {
  final List<TextFieldModel> listOfFields;

  ExtraInfoModel({required this.listOfFields});

  factory ExtraInfoModel.fromJson(Map<String, dynamic> json) => ExtraInfoModel(
      listOfFields: json.keys
          .map((key) => TextFieldModel.fromJson(key, json[key]))
          .toList());

  Map<String, dynamic> toJson() {
    Map<String, String> extraInfo = {};

    for (TextFieldModel value in listOfFields) {
      extraInfo[value.key] = value.value;
    }

    return extraInfo;
  }
}
