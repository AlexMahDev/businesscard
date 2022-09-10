part of 'new_card_bloc.dart';

@immutable
abstract class NewCardEvent {}

class AddCardInfoEvent extends NewCardEvent {

  final CardModel card;

  AddCardInfoEvent(this.card);

}
