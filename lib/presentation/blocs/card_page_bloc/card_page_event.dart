part of 'card_page_bloc.dart';

@immutable
abstract class CardPageEvent {}

class ChangeCardPageEvent extends CardPageEvent {

  final int cardPage;

  ChangeCardPageEvent(this.cardPage);

}
