part of 'share_card_bloc.dart';

@immutable
abstract class ShareCardState {}

class ShareCardByScanState extends ShareCardState {}

class ShareCardByTextState extends ShareCardState {}

class ShareCardByEmailState extends ShareCardState {}

class ShareCardByCopyState extends ShareCardState {}