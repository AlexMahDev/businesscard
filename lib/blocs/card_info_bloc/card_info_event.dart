part of 'card_info_bloc.dart';

@immutable
abstract class CardInfoEvent {}

class GetCardInfoEvent extends CardInfoEvent {}

class AddCardEvent extends CardInfoEvent {

  final List<CardModel> cards;
  final CardModel newCard;

  AddCardEvent(this.cards, this.newCard);

}

class AddExtraInfoEvent extends CardInfoEvent {

  final List<CardModel> cards;

  AddExtraInfoEvent(this.cards);

}
