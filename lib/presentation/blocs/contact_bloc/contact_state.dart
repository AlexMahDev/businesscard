part of 'contact_bloc.dart';

@immutable
abstract class ContactState {}

class ContactInitialState extends ContactState {}

class ContactLoadingState extends ContactState {}

class ContactLoadedState extends ContactState {
  final List<ContactModel> contacts;

  ContactLoadedState(this.contacts);
}

class ContactErrorState extends ContactState {}

class ContactEmptyState extends ContactState {}

class SearchLinkLoadingState extends ContactState {}

class SearchLinkSuccessState extends ContactState {
  final CardModel card;

  SearchLinkSuccessState(this.card);
}

class SearchLinkErrorState extends ContactState {}

class ContactSearchState extends ContactState {
  final List<ContactModel> contacts;
  final List<ContactModel> foundContacts;

  ContactSearchState(this.contacts, this.foundContacts);
}

class SaveContactLoadingState extends ContactState {}

class SaveContactSuccessState extends ContactState {}

class SaveContactErrorState extends ContactState {}

class DelContactLoadingState extends ContactState {}

class DelContactSuccessState extends ContactState {}

class DelContactErrorState extends ContactState {}
