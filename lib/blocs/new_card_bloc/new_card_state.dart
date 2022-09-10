part of 'new_card_bloc.dart';

@immutable
abstract class NewCardState {}

class NewCardInitialState extends NewCardState {

  final CardModel card;

  NewCardInitialState(this.card);

}
