import 'package:businesscard/data/models/card_model.dart';

// class ContactModel extends GeneralInfoModel {
//
//   final int timestamp;
//   final String cardId;
//   final String ownerId;
//
//   ContactModel(
//       {required this.timestamp,
//       required this.cardId,
//         required this.ownerId,
//       required super.cardTitle,
//       required super.firstName,
//       required super.middleName,
//       required super.lastName,
//       required super.jobTitle,
//       required super.department,
//       required super.companyName,
//       required super.headLine,
//       required super.profileImage,
//       required super.logoImage});
//
//   factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
//       timestamp: json['timestamp'],
//       cardId: json['cardId'],
//       ownerId: json['ownerId'],
//       cardTitle: json["cardTitle"],
//       firstName: json["firstName"],
//       middleName: json["middleName"],
//       lastName: json["lastName"],
//       jobTitle: json["jobTitle"],
//       department: json["department"],
//       companyName: json["companyName"],
//       headLine: json["headLine"],
//       profileImage: json["profileImage"],
//       logoImage: json["logoImage"]);
//
//
//   @override
//   Map<String, dynamic> toJson() => {
//         "timestamp": timestamp,
//         "cardId": cardId,
//     "ownerId" : ownerId,
//     "cardTitle" : cardTitle,
//     "firstName" : firstName,
//     "middleName" : middleName,
//     "lastName" : lastName,
//     "jobTitle" : jobTitle,
//     "department" : department,
//     "companyName" : companyName,
//     "headLine" : headLine,
//     "profileImage" : profileImage,
//     "logoImage" : logoImage
//       };
// }


class ContactModel extends GeneralInfoModel {

  final int timestamp;
  final String cardId;
  final String ownerId;

  ContactModel(
      {required this.timestamp,
      required this.cardId,
        required this.ownerId,
      required super.cardTitle,
      required super.firstName,
      required super.middleName,
      required super.lastName,
      required super.jobTitle,
      required super.department,
      required super.companyName,
      required super.headLine,
      required super.profileImage,
      required super.logoImage});

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
      timestamp: json['timestamp'],
      cardId: json['cardId'],
      ownerId: json['ownerId'],
      cardTitle: json["cardTitle"],
      firstName: json["firstName"],
      middleName: json["middleName"],
      lastName: json["lastName"],
      jobTitle: json["jobTitle"],
      department: json["department"],
      companyName: json["companyName"],
      headLine: json["headLine"],
      profileImage: json["profileImage"],
      logoImage: json["logoImage"]);


  @override
  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "cardId": cardId,
    "ownerId" : ownerId,
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

