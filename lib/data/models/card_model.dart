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

class CardModel {
  final String fullName;
  final String jobTitle;
  final String department;
  final String companyName;
  final String headLine;

  final String phoneNumber;
  final String email;
  final String link;
  final String linkedIn;
  final String gitHub;
  final String telegram;

  CardModel({
    required this.fullName,
    required this.jobTitle,
    required this.department,
    required this.companyName,
    required this.headLine,
    required this.phoneNumber,
    required this.email,
    required this.link,
    required this.linkedIn,
    required this.gitHub,
    required this.telegram
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        fullName: json["setup"],
        jobTitle: json["delivery"],
        department: json["id"],
        companyName: json["id"],
        headLine: json["id"],
        phoneNumber: json["id"],
        email: '',
        link: '',
        linkedIn: '',
        gitHub: '',
        telegram: '',
  );

  Map<String, dynamic> toJson() =>
      {
        "setup": fullName
      };
}
