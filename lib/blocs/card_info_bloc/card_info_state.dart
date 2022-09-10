part of 'card_info_bloc.dart';

@immutable
abstract class CardInfoState {}

class CardInfoInitialState extends CardInfoState {}


class CardInfoLoadingState extends CardInfoState {}

class CardInfoLoadedState extends CardInfoState {

  final List<CardModel> cards;

  CardInfoLoadedState(this.cards);

}

class CardInfoErrorState extends CardInfoState {}