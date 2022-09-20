

import 'package:businesscard/data/models/card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'dynamic_link_repository.dart';

class CardRepository {

  // List<Map<String, dynamic>> listOfCards = [
  //
  //   {
  //     "cardId": 1,
  //     "timestamp": 123456
  //     "settings": {
  //       //"cardTitle": "Job",
  //       "cardColor": 4294922834,
  //     },
  //     "generalInfo": {
  //       "cardTitle": "Job",
  //       "firstName": "Alexander",
  //       "middleName": "Mikhailovich",
  //       "lastName": "Makhrachyov",
  //       "jobTitle": "Head Of Mobile",
  //       "department": "Mobile",
  //       "companyName": "Innowise",
  //       "headLine": "Hi!",
  //       "profileImage": "https://broncolor.swiss/assets/img/Stories/Inspiration/Daniel-Radcliffe/_contentWithShareBar23/DANIEL-RADCLIFFE-featured.jpg",
  //       "logoImage": ""
  //     },
  //     "extraInfo": {
  //       "email": "myemail@gmail.com",
  //     },
  //
  //   },
  //
  //   {
  //     "cardId": 2,
  //     "timestamp": 123456
  //     "settings": {
  //       "cardColor": 4294922834,
  //     },
  //     "generalInfo": {
  //       "cardTitle": "Job",
  //       "firstName": "Alexander",
  //       "middleName": "Mikhailovich",
  //       "lastName": "test",
  //       "jobTitle": "test",
  //       "department": "Mobile",
  //       "companyName": "test",
  //       "headLine": "Hi!",
  //       "profileImage": "https://broncolor.swiss/assets/img/Stories/Inspiration/Daniel-Radcliffe/_contentWithShareBar23/DANIEL-RADCLIFFE-featured.jpg",
  //       "logoImage": "https://scontent-waw1-1.xx.fbcdn.net/v/t39.30808-6/215485554_10159431724164660_8100659849944415055_n.png?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=WUhRQ7j_fr8AX-aIi3O&_nc_ht=scontent-waw1-1.xx&oh=00_AT8EUagE3wtnp-EPMVpVE9x9GTcrmOsITCKpNEXC7zzVtA&oe=632456A9"
  //     },
  //     "extraInfo": {
  //       "email": "test@gmail.com",
  //     },
  //
  //   }
  //
  // ];

  Future<List<CardModel>> getCards(String uid) async {

    try {
      final cards = await FirebaseFirestore.instance.collection("users").doc(uid).collection("cards").orderBy('timestamp').get();
      //return List.from(listOfCards.map((e) => CardModel.fromJson(e)));
      return cards.docs.isNotEmpty ? List.from(cards.docs.map((e) => CardModel.fromJson(e.data()))) : [];
    } catch (e) {
      throw Exception(e);
    }

  }


  Future<void> createCard(String uid, CardModel newCard) async {

    final card = FirebaseFirestore.instance.collection("users").doc(uid).collection("cards").doc();

    newCard.cardId = card.id;

    // final DynamicLinkParameters dynamicLinkParams =
    // DynamicLinkParameters(
    //   uriPrefix: 'https://alexmahdev.page.link',
    //   link: Uri.parse('https://alexmahdev.page.link/$uid/${card.id}'),
    //   androidParameters: AndroidParameters(
    //     packageName: 'by.alexmahdev.bcard',
    //     fallbackUrl: Uri.parse('https://github.com/AlexMahDev/businesscard'),
    //   ),
    //   iosParameters: IOSParameters(
    //     bundleId: 'by.alexmahdev.bcard',
    //     //appStoreId: '962194608',
    //     fallbackUrl: Uri.parse('https://github.com/AlexMahDev/businesscard'),
    //   ),
    //   socialMetaTagParameters: SocialMetaTagParameters(
    //     title: "BCard",
    //     imageUrl: Uri.parse("https://firebasestorage.googleapis.com/v0/b/bcard-f4f4b.appspot.com/o/dynamic-link%2Fpreview.png?alt=media&token=1b1aa88b-cef2-4ec3-90ee-845d978e1977"),
    //   ),
    // );

    try {
      //final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
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