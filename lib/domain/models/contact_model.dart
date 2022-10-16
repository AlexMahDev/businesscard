import 'card_model.dart';

class ContactModel{

  final int timestamp;
  final String contactId;
  final CardModel cardModel;

  ContactModel(
      {required this.timestamp,
        required this.contactId,
        required this.cardModel});

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
      timestamp: json['timestamp'],
      contactId: json['contactId'],
      cardModel: CardModel.fromJson(json['card'])
  );



  Map<String, dynamic> toJson() => {
    "timestamp": timestamp,
    "contactId" : contactId,
    "card": cardModel.toJson()
  };
}
