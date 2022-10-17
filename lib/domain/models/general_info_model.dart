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

  GeneralInfoModel(
      {required this.cardTitle,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.jobTitle,
      required this.department,
      required this.companyName,
      required this.headLine,
      required this.profileImage,
      required this.logoImage});

  factory GeneralInfoModel.fromJson(Map<String, dynamic> json) =>
      GeneralInfoModel(
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

  Map<String, dynamic> toJson() => {
        "cardTitle": cardTitle,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "jobTitle": jobTitle,
        "department": department,
        "companyName": companyName,
        "headLine": headLine,
        "profileImage": profileImage,
        "logoImage": logoImage
      };
}
