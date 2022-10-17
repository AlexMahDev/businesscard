part of 'card_info_bloc.dart';

@immutable
abstract class CardInfoEvent {}

class GetCardInfoEvent extends CardInfoEvent {}

class AddCardEvent extends CardInfoEvent {

  final List<CardModel> cards;
  final CardModel newCard;

  AddCardEvent(this.cards, this.newCard);

}


class UpdateCardEvent extends CardInfoEvent {

  final List<CardModel> cards;
  final CardModel newCard;

  UpdateCardEvent(this.cards, this.newCard);

}


class DeleteCardEvent extends CardInfoEvent {

  final List<CardModel> cards;
  final String cardId;

  DeleteCardEvent(this.cards, this.cardId);

}
