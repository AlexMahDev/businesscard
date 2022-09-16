

import 'package:businesscard/data/models/card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardRepository {

  // List<Map<String, dynamic>> listOfCards = [
  //
  //   {
  //     "cardId": 1,
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

    print(uid);

    // final card = FirebaseFirestore.instance.collection("users").doc(uid).collection("cards").doc();
    //
    // CardModel newCard = CardModel(
    //   cardId: card.id,
    //     settings: SettingsModel(
    //         cardColor: 4294922834),
    //     generalInfo: GeneralInfoModel(
    //         cardTitle: 'Title',
    //         firstName: "firstName.text",
    //         middleName: "middleName.text",
    //         lastName: "lastName.text",
    //         jobTitle: "jobTitle.text",
    //         department: "department.text",
    //         companyName: "companyName.text",
    //         headLine: "headLine.text",
    //         profileImage: '',
    //         logoImage: ''),
    //     extraInfo: ExtraInfoModel(listOfFields: []));
    //
    // await card.set(newCard.toJson());

    try {
      final cards = await FirebaseFirestore.instance.collection("users").doc(uid).collection("cards").get();
      //return List.from(listOfCards.map((e) => CardModel.fromJson(e)));
      return cards.docs.isNotEmpty ? List.from(cards.docs.map((e) => CardModel.fromJson(e.data()))) : [];
    } catch (e) {
      throw Exception(e);
    }

  }


  Future<void> createCard(String uid, CardModel newCard) async {

    //print(uid);

    final card = FirebaseFirestore.instance.collection("users").doc(uid).collection("cards").doc();

    // CardModel newCard = CardModel(
    //   cardId: card.id,
    //     settings: SettingsModel(
    //         cardColor: 4294922834),
    //     generalInfo: GeneralInfoModel(
    //         cardTitle: 'Title',
    //         firstName: "firstName.text",
    //         middleName: "middleName.text",
    //         lastName: "lastName.text",
    //         jobTitle: "jobTitle.text",
    //         department: "department.text",
    //         companyName: "companyName.text",
    //         headLine: "headLine.text",
    //         profileImage: '',
    //         logoImage: ''),
    //     extraInfo: ExtraInfoModel(listOfFields: []));

    newCard.cardId = card.id;

    try {
      await card.set(newCard.toJson());
    } catch (e) {
      throw Exception(e);
    }

  }


}