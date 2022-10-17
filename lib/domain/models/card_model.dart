import 'package:businesscard/domain/models/settings_model.dart';
import 'extra_info_model.dart';
import 'general_info_model.dart';

class CardModel {
  final int timestamp;
  String cardId;
  String qrLink;
  final SettingsModel settings;
  final GeneralInfoModel generalInfo;
  final ExtraInfoModel extraInfo;

  CardModel(
      {required this.timestamp,
      required this.cardId,
      required this.qrLink,
      required this.settings,
      required this.generalInfo,
      required this.extraInfo});

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
      timestamp: json['timestamp'],
      cardId: json['cardId'],
      qrLink: json['qrLink'],
      settings: SettingsModel.fromJson(json['settings']),
      generalInfo: GeneralInfoModel.fromJson(json['generalInfo']),
      extraInfo: ExtraInfoModel.fromJson(json['extraInfo']));

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "cardId": cardId,
        "qrLink": qrLink,
        "settings": settings.toJson(),
        "generalInfo": generalInfo.toJson(),
        "extraInfo": extraInfo.toJson()
      };
}
