
class CardModel {

  final int timestamp;
  String cardId;
  String qrLink;
  final SettingsModel settings;
  final GeneralInfoModel generalInfo;
  final ExtraInfoModel extraInfo;


  CardModel({
    required this.timestamp,
    required this.cardId,
    required this.qrLink,
    required this.settings,
    required this.generalInfo,
    required this.extraInfo
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
      timestamp: json['timestamp'],
      cardId: json['cardId'],
      qrLink: json['qrLink'],
      settings: SettingsModel.fromJson(json['settings']),
      generalInfo: GeneralInfoModel.fromJson(json['generalInfo']),
      extraInfo: ExtraInfoModel.fromJson(json['extraInfo'])
  );

  Map<String, dynamic> toJson() =>
      {
        "timestamp" : timestamp,
        "cardId" : cardId,
        "qrLink" : qrLink,
        "settings": settings.toJson(),
        "generalInfo": generalInfo.toJson(),
        "extraInfo": extraInfo.toJson()
      };
}


class SettingsModel {

  final int cardColor;

  SettingsModel({required this.cardColor});

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
    cardColor: json["cardColor"],
  );

  Map<String, dynamic> toJson() =>
      {
        "cardColor": cardColor
      };

}


class GeneralInfoModel {

  final String cardTitle;
  final String firstName;
  final String middleName;
  final String lastName;
  final String jobTitle;
  final String department;
  final String companyName;
  final String headLine;
  final String profileImage;
  final String logoImage;

  GeneralInfoModel({required this.cardTitle, required this.firstName, required this.middleName, required this.lastName, required this.jobTitle, required this.department, required this.companyName, required this.headLine, required this.profileImage, required this.logoImage});


  factory GeneralInfoModel.fromJson(Map<String, dynamic> json) => GeneralInfoModel(
      cardTitle: json["cardTitle"],
      firstName: json["firstName"],
      middleName: json["middleName"],
      lastName: json["lastName"],
      jobTitle: json["jobTitle"],
      department: json["department"],
      companyName: json["companyName"],
      headLine: json["headLine"],
      profileImage: json["profileImage"],
      logoImage: json["logoImage"]
  );

  Map<String, dynamic> toJson() =>
      {
        "cardTitle" : cardTitle,
        "firstName" : firstName,
        "middleName" : middleName,
        "lastName" : lastName,
        "jobTitle" : jobTitle,
        "department" : department,
        "companyName" : companyName,
        "headLine" : headLine,
        "profileImage" : profileImage,
        "logoImage" : logoImage
      };


}


class ExtraInfoModel {

  final List<TextFieldModel> listOfFields;

  ExtraInfoModel({required this.listOfFields});


  factory ExtraInfoModel.fromJson(Map<String, dynamic> json) => ExtraInfoModel(
      listOfFields: json.keys.map((key) => TextFieldModel.fromJson(key, json[key])).toList()
  );

  Map<String, dynamic> toJson() {

    Map<String, String> extraInfo = {};

    for(TextFieldModel value in listOfFields) {

      extraInfo[value.key] = value.value;

    }

    return extraInfo;


  }



}

class TextFieldModel {

  final String key;
  final String value;

  TextFieldModel({required this.key, required this.value});

  factory TextFieldModel.fromJson(String title, String value) => TextFieldModel(
      key: title,
      value: value
  );



}