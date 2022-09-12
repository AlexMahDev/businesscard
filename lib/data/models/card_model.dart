

// Map<String, Map<String, String>> data =
//
// {
//   "generalInfo": {
//     "Full_Name": "Alexander Makhrachyov",
//     "Job_Title": "Head Of Mobile",
//     "Department": "Mobile",
//     "Company_Name": "Innowise",
//     "Headline": "Hi!"
//   },
//   "extraInfo": {
//     "Email": "myemail@gmail.com",
//   },
//
// };


// Map<String, Map<String, String>> data =
//
// {
//   "generalInfo": {
//     "Full_Name": "Alexander Makhrachyov",
//     "Job_Title": "Head Of Mobile",
//     "Department": "Mobile",
//     "Company_Name": "Innowise",
//     "Headline": "Hi!"
//   },
//   "extraInfo": {
//     "Email": "myemail@gmail.com",
//   },
//
// };

// class CardModel {
//
//   final String fullName;
//   final String jobTitle;
//   final String department;
//   final String companyName;
//   final String headLine;
//
//   final String phoneNumber;
//   final String email;
//   final String link;
//   final String linkedIn;
//   final String gitHub;
//   final String telegram;
//
//   CardModel({
//     required this.fullName,
//     required this.jobTitle,
//     required this.department,
//     required this.companyName,
//     required this.headLine,
//     required this.phoneNumber,
//     required this.email,
//     required this.link,
//     required this.linkedIn,
//     required this.gitHub,
//     required this.telegram
//   });
//
//   factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
//         fullName: json["setup"],
//         jobTitle: json["delivery"],
//         department: json["id"],
//         companyName: json["id"],
//         headLine: json["id"],
//         phoneNumber: json["id"],
//         email: '',
//         link: '',
//         linkedIn: '',
//         gitHub: '',
//         telegram: '',
//   );
//
//   Map<String, dynamic> toJson() =>
//       {
//         "setup": fullName
//       };
// }



// List<Map<String, Map<String, dynamic>>> listOfCards = [
//
//   {
//     "generalInfo": {
//       "Full_Name": "Alexander Makhrachyov",
//       "Job_Title": "Head Of Mobile",
//       "Department": "Mobile",
//       "Company_Name": "Innowise",
//       "Headline": "Hi!"
//     },
//     "extraInfo": {
//       "Email": "myemail@gmail.com",
//     },
//
//   }
//
// ];

class CardModel {

  SettingsModel settings;
  GeneralInfoModel generalInfo;
  ExtraInfoModel extraInfo;


  CardModel({
    required this.settings,
    required this.generalInfo,
    required this.extraInfo
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
      settings: SettingsModel.fromJson(json['settings']),
      generalInfo: GeneralInfoModel.fromJson(json['generalInfo']),
      extraInfo: ExtraInfoModel.fromJson(json['extraInfo'])
  );

  Map<String, dynamic> toJson() =>
      {
        "settings": settings,
        "generalInfo": generalInfo,
        "extraInfo": extraInfo
      };
}


class SettingsModel {

  final int cardColor;

  SettingsModel({required this.cardColor});

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
    cardColor: json["cardColor"],
  );

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

  GeneralInfoModel({required this.cardTitle, required this.firstName, required this.middleName, required this.lastName, required this.jobTitle, required this.department, required this.companyName, required this.headLine});


  factory GeneralInfoModel.fromJson(Map<String, dynamic> json) => GeneralInfoModel(
      cardTitle: json["cardTitle"],
      firstName: json["firstName"],
      middleName: json["middleName"],
      lastName: json["lastName"],
      jobTitle: json["jobTitle"],
      department: json["department"],
      companyName: json["companyName"],
      headLine: json["headLine"],
  );


}

// class GeneralInfoModel {
//
//   final List<TextFieldModel> listOfFields;
//
//   GeneralInfoModel({required this.listOfFields});
//
//
//   factory GeneralInfoModel.fromJson(Map<String, dynamic> json) => GeneralInfoModel(
//       //listOfFields: json.entries.map((e) => FieldModel.fromJson(e)).toList()
//       listOfFields: json.keys.map((key) => TextFieldModel.fromJson(key, json[key])).toList()
//     //extraInfo: json["extraInfo"]
//   );
//
//
// }

class ExtraInfoModel {

  final List<TextFieldModel> listOfFields;

  ExtraInfoModel({required this.listOfFields});


  factory ExtraInfoModel.fromJson(Map<String, dynamic> json) => ExtraInfoModel(
      listOfFields: json.keys.map((key) => TextFieldModel.fromJson(key, json[key])).toList()
    //extraInfo: json["extraInfo"]
  );


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