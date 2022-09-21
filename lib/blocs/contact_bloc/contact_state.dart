part of 'contact_bloc.dart';

@immutable
abstract class ContactState {}

class ContactInitialState extends ContactState {}

class ContactLoadingState extends ContactState {}

class ContactLoadedState extends ContactState {

  final List<ContactModel> contacts;

  ContactLoadedState(this.contacts);

}

class ContactSearchState extends ContactState {

  final List<ContactModel> contacts;
  final List<ContactModel> foundContacts;

  ContactSearchState(this.contacts, this.foundContacts);

}

class ContactErrorState extends ContactState {}

class ContactEmptyState extends ContactState {}



class DelContactLoadingState extends ContactState {}

class SaveContactLoadedState extends ContactState {}

