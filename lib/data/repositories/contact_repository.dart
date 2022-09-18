

import 'package:businesscard/data/models/card_model.dart';
import 'package:businesscard/data/models/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactRepository {

  List<ContactModel> contacts = [];
  CardModel? contactCard;

  Future<void> getContacts(String uid) async {

    try {
      final contactsReq = await FirebaseFirestore.instance.collection("users").doc(uid).collection("contacts").orderBy('timestamp').get();

      contactsReq.docs.isNotEmpty ? contacts = List.from(contactsReq.docs.map((e) => ContactModel.fromJson(e.data()))) : [];

      //return contactsReq.docs.isNotEmpty ? List.from(contacts.docs.map((e) => ContactModel.fromJson(e.data()))) : [];
    } catch (e) {
      throw Exception(e);
    }

  }


  Future<void> getContactInfo(String uid, String cardId) async {

    try {
      final contactCardReq = await FirebaseFirestore.instance.collection("users").doc(uid).collection("contacts").doc(cardId).get();
      if (contactCardReq.exists) {
        contactCard = CardModel.fromJson(contactCardReq.data()!);
      }
    } catch (e) {
      throw Exception(e);
    }

  }



}