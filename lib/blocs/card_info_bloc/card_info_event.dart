part of 'card_info_bloc.dart';

@immutable
abstract class CardInfoEvent {}

class GetCardInfoEvent extends CardInfoEvent {}

class AddCardInfoEvent extends CardInfoEvent {

  final List<CardModel> cards;

  AddCardInfoEvent(this.cards);

}