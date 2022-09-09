part of 'card_info_bloc.dart';

@immutable
abstract class CardInfoState {}

class CardInfoInitialState extends CardInfoState {}


class CardInfoLoadingState extends CardInfoState {}

class CardInfoLoadedState extends CardInfoState {

  final CardModel card;

  CardInfoLoadedState(this.card);

}

class CardInfoErrorState extends CardInfoState {}