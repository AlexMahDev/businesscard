

import 'package:businesscard/data/models/card_model.dart';
import 'package:businesscard/data/models/contact_model.dart';
import 'package:businesscard/data/repositories/card_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactRepository {

  //List<ContactModel> contacts = [];
  //CardModel? contactCard;

  Future<List<ContactModel>> getContacts() async {

    final user = FirebaseAuth.instance.currentUser!;

    // await Future.delayed(const Duration(seconds: 4), () {
    //   print('One second has passed.'); // Prints after 1 second.
    // });

    try {
      final contactsReq = await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("contacts").orderBy('timestamp').get();
      return contactsReq.docs.isNotEmpty ? List.from(contactsReq.docs.map((e) => ContactModel.fromJson(e.data()))) : [];

      //return contactsReq.docs.isNotEmpty ? List.from(contacts.docs.map((e) => ContactModel.fromJson(e.data()))) : [];
    } catch (e) {
      print(e);
      throw Exception(e);
    }

  }


  // Future<void> getContactInfo(String uid, String cardId) async {
  //
  //   try {
  //     final contactCardReq = await FirebaseFirestore.instance.collection("users").doc(uid).collection("contacts").doc(cardId).get();
  //     if (contactCardReq.exists) {
  //       contactCard = CardModel.fromJson(contactCardReq.data()!);
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  //
  // }


  // Future<CardModel?> saveContact(String uid, String cardId) async {
  //
  //   final user = FirebaseAuth.instance.currentUser!;
  //
  //   try {
  //     final CardModel? card = await CardRepository().getCard(uid, cardId);
  //     if(card != null) {
  //       final contactFirebase = FirebaseFirestore.instance.collection("users").doc(user.uid).collection("contacts").doc();
  //       final ContactModel contactModel = ContactModel(timestamp: DateTime.now().millisecondsSinceEpoch, contactId: contactFirebase.id, cardModel: card);
  //       await contactFirebase.set(contactModel.toJson());
  //       return card;
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  //
  //   return null;
  //
  // }



  Future<void> saveContact(CardModel card) async {

    final user = FirebaseAuth.instance.currentUser!;

    try {
        final contactFirebase = FirebaseFirestore.instance.collection("users").doc(user.uid).collection("contacts").doc(card.cardId);
        final ContactModel contactModel = ContactModel(timestamp: DateTime.now().millisecondsSinceEpoch, contactId: card.cardId, cardModel: card);
        await contactFirebase.set(contactModel.toJson());
    } catch (e) {
      throw Exception(e);
    }

  }





}