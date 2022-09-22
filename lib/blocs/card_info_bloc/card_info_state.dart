part of 'card_info_bloc.dart';

@immutable
abstract class CardInfoState {}

class CardInfoInitialState extends CardInfoState {}


class CardInfoLoadingState extends CardInfoState {}

class CardInfoLoadedState extends CardInfoState {

  final List<CardModel> cards;

  CardInfoLoadedState(this.cards);

}

class CardInfoEmptyState extends CardInfoState {

  final List<CardModel> cards;

  CardInfoEmptyState(this.cards);

}

class CardInfoErrorState extends CardInfoState {}



class AddCardLoadingState extends CardInfoState {}
class AddCardSuccessState extends CardInfoState {}
class AddCardErrorState extends CardInfoState {}

class UpdateCardLoadingState extends CardInfoState {}
class UpdateCardSuccessState extends CardInfoState {}
class UpdateCardErrorState extends CardInfoState {}

class DeleteCardLoadingState extends CardInfoState {}
class DeleteCardSuccessState extends CardInfoState {}
class DeleteCardErrorState extends CardInfoState {}