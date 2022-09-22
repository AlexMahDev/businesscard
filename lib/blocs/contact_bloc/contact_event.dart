part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

class GetContactEvent extends ContactEvent {}

class SaveContactEvent extends ContactEvent {

  final CardModel newContact;

  SaveContactEvent(this.newContact);

}

class SaveContactManualEvent extends ContactEvent {

  final String url;
  final List<ContactModel> contacts;


  SaveContactManualEvent(this.url, this.contacts);

}

class GetContactByNameEvent extends ContactEvent {

  final String name;
  final List<ContactModel> contacts;

  GetContactByNameEvent(this.name, this.contacts);

}


class DeleteContactEvent extends ContactEvent {

  final String contactId;
  final List<ContactModel> contacts;

  DeleteContactEvent(this.contactId, this.contacts);

}



