import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:businesscard/data/models/contact_model.dart';
import 'package:meta/meta.dart';

import '../../data/models/card_model.dart';
import '../../data/repositories/contact_repository.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {

  final ContactRepository contactRepository;

  ContactBloc({required this.contactRepository}) : super(ContactInitialState()) {
    on<GetContactEvent>(_getContacts);
    on<SaveContactEvent>(_saveContact);
    on<GetContactByNameEvent>(_getContactsByName);
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

    emit(ContactLoadingState());

    try {
      await contactRepository.saveContact(event.newContact);
      final List<ContactModel> contacts = await contactRepository.getContacts();
      emit(ContactLoadedState(contacts));
    } catch (e) {
      emit(ContactErrorState());
    }


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


}
