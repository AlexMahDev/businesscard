part of 'share_card_bloc.dart';

@immutable
abstract class ShareCardEvent {}

class ChangeShareCardMethodEvent extends ShareCardEvent {

  final String shareMethodName;

  ChangeShareCardMethodEvent(this.shareMethodName);
}