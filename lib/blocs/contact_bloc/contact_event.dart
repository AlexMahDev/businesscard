part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

class GetContactEvent extends ContactEvent {}

class SaveContactEvent extends ContactEvent {

  final CardModel newContact;

  SaveContactEvent(this.newContact);

}


