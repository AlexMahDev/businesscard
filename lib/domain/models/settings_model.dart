class SettingsModel {
  final int cardColor;

  SettingsModel({required this.cardColor});

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        cardColor: json["cardColor"],
      );

  Map<String, dynamic> toJson() => {"cardColor": cardColor};
}
