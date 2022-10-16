import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/card_model.dart';
import 'dynamic_link_repository.dart';

class CardRepository {


  Future<List<CardModel>> getCards(String uid) async {

    try {
      final cards = await FirebaseFirestore.instance.collection("users").doc(uid).collection("cards").orderBy('timestamp').get();
      return cards.docs.isNotEmpty ? List.from(cards.docs.map((e) => CardModel.fromJson(e.data()))) : [];
    } catch (e) {
      throw Exception(e);
    }

  }

  Future<CardModel?> getCard(String uid, String cardId) async {

    try {
      final card = await FirebaseFirestore.instance.collection("users").doc(uid).collection("cards").doc(cardId).get();
      if(card.data() != null) {
        return CardModel.fromJson(card.data()!);
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }

  }

  Future<void> createCard(String uid, CardModel newCard) async {

    final card = FirebaseFirestore.instance.collection("users").doc(uid).collection("cards").doc();

    newCard.cardId = card.id;


    try {
      final dynamicLink = await DynamicLinkRepository().createDynamicLink(uid, card.id);
      String qrLink = dynamicLink!.shortUrl.toString();
      newCard.qrLink = qrLink;
      await card.set(newCard.toJson());
    } catch (e) {
      throw Exception(e);
    }

  }


  Future<void> updateCard(String uid, CardModel newCard) async {

    final card = FirebaseFirestore.instance.collection("users").doc(uid).collection("cards").doc(newCard.cardId);

    try {
      await card.set(newCard.toJson());
    } catch (e) {
      throw Exception(e);
    }

  }

  Future<void> deleteCard(String uid, String cardId) async {

    final card = FirebaseFirestore.instance.collection("users").doc(uid).collection("cards").doc(cardId);

    try {
      await card.delete();
    } catch (e) {
      throw Exception(e);
    }

  }


}