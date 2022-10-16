
import 'package:businesscard/data/repositories/card_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/models/card_model.dart';
import '../../domain/models/contact_model.dart';

class ContactRepository {


  Future<List<ContactModel>> getContacts() async {

    final user = FirebaseAuth.instance.currentUser!;

    try {
      final contactsReq = await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("contacts").orderBy('timestamp').get();
      return contactsReq.docs.isNotEmpty ? List.from(contactsReq.docs.map((e) => ContactModel.fromJson(e.data()))) : [];
    } catch (e) {
      throw Exception(e);
    }

  }




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


  Future<void> deleteContact(String cardId) async {

    final user = FirebaseAuth.instance.currentUser!;

    try {
      final contactFirebase = FirebaseFirestore.instance.collection("users").doc(user.uid).collection("contacts").doc(cardId);
      await contactFirebase.delete();
    } catch (e) {
      throw Exception(e);
    }

  }




}