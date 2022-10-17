import 'package:bloc/bloc.dart';
import 'package:businesscard/data/repositories/dynamic_link_repository.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/contact_repository.dart';
import '../../../domain/models/card_model.dart';
import '../../../domain/models/contact_model.dart';


part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {

  final ContactRepository contactRepository;

  ContactBloc({required this.contactRepository}) : super(ContactInitialState()) {
    on<GetContactEvent>(_getContacts);
    on<SaveContactEvent>(_saveContact);
    on<GetContactByNameEvent>(_getContactsByName);
    on<DeleteContactEvent>(_deleteContact);
    on<SaveContactManualEvent>(_saveContactManual);
  }

  _getContacts(GetContactEvent event, Emitter<ContactState> emit) async {

    emit(ContactLoadingState());

    try {
      final List<ContactModel> contacts = await contactRepository.getContacts();
      emit(ContactLoadedState(contacts));
    } catch (e) {
      emit(ContactErrorState());
    }

  }



  _saveContact(SaveContactEvent event, Emitter<ContactState> emit) async {

    emit(SaveContactLoadingState());

    try {
      await contactRepository.saveContact(event.newContact);
      emit(SaveContactSuccessState());
    } catch (e) {
      emit(SaveContactErrorState());
    }

    try {
      final List<ContactModel> contacts = await contactRepository.getContacts();
      emit(ContactLoadedState(contacts));
    } catch (e) {
      emit(ContactErrorState());
    }



  }




  _saveContactManual(SaveContactManualEvent event, Emitter<ContactState> emit) async {

    emit(SearchLinkLoadingState());

    Uri url = Uri.parse(event.url);

    try {
      final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getDynamicLink(url);
      if(data != null) {
        CardModel? card = await DynamicLinkRepository().handleDynamicLinkManual(data.link);
        if(card != null) {
          emit(SearchLinkSuccessState(card));
        }
      }
    } catch (e) {
      emit(SearchLinkErrorState());
    }

    emit(ContactLoadedState(event.contacts));

  }





  _getContactsByName(GetContactByNameEvent event, Emitter<ContactState> emit) async {

    bool isFullNameContainsSearchName(String fullName) {

      if(fullName.contains(event.name)) {
        return true;
      } else {
        return false;
      }

    }

    if (event.name.isNotEmpty) {
      List<ContactModel> foundContacts = event.contacts.where((element) => isFullNameContainsSearchName('${element.cardModel.generalInfo.firstName} ${element.cardModel.generalInfo.middleName} ${element.cardModel.generalInfo.lastName}')).toList();
      emit(ContactSearchState(event.contacts, foundContacts));
    } else {
      emit(ContactLoadedState(event.contacts));
    }

  }





  _deleteContact(DeleteContactEvent event, Emitter<ContactState> emit) async {

    emit(DelContactLoadingState());

    List<ContactModel> contacts = event.contacts;

    try {
      await contactRepository.deleteContact(event.contactId);
      contacts.removeWhere((element) => element.contactId == event.contactId);
      emit(DelContactSuccessState());
    } catch (e) {
      emit(DelContactErrorState());
    }

    emit(ContactLoadedState(contacts));

  }


}
