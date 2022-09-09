

List<Map<String, Map<String, String>>> listOfCards = [

  {
    "generalInfo": {
      "Full_Name": "Alexander Makhrachyov",
      "Job_Title": "Head Of Mobile",
      "Department": "Mobile",
      "Company_Name": "Innowise",
      "Headline": "Hi!"
    },
    "extraInfo": {
      "Email": "myemail@gmail.com",
    },

  }

];

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



class CardModel {

  GeneralInfo generalInfo;
  ExtraInfo extraInfo;


  CardModel({
    required this.generalInfo,
    required this.extraInfo
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
      generalInfo: GeneralInfo.fromJson(json['generalInfo']),
      extraInfo: ExtraInfo.fromJson(json['extraInfo'])
  );

  Map<String, dynamic> toJson() =>
      {
        "generalInfo": generalInfo,
        "extraInfo": extraInfo
      };
}


class GeneralInfo {

  final List<TextFieldModel> listOfFields;

  GeneralInfo({required this.listOfFields});


  factory GeneralInfo.fromJson(Map<String, dynamic> json) => GeneralInfo(
      //listOfFields: json.entries.map((e) => FieldModel.fromJson(e)).toList()
      listOfFields: json.keys.map((key) => TextFieldModel.fromJson(key, json[key])).toList()
    //extraInfo: json["extraInfo"]
  );


}

class ExtraInfo {

  final List<TextFieldModel> listOfFields;

  ExtraInfo({required this.listOfFields});


  factory ExtraInfo.fromJson(Map<String, dynamic> json) => ExtraInfo(
      listOfFields: json.keys.map((key) => TextFieldModel.fromJson(key, json[key])).toList()
    //extraInfo: json["extraInfo"]
  );


}

class TextFieldModel {

  final String title;
  final String value;

  TextFieldModel({required this.title, required this.value});

  factory TextFieldModel.fromJson(String title, String value) => TextFieldModel(
      title: title,
      value: value
  );

}