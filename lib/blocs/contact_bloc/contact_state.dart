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