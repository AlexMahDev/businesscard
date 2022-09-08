import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'share_card_event.dart';
part 'share_card_state.dart';

class ShareCardBloc extends Bloc<ShareCardEvent, ShareCardState> {
  ShareCardBloc() : super(ShareCardByScanState()) {
    on<ChangeShareCardMethodEvent>(_changeShareCardMethod);
  }

  _changeShareCardMethod(ChangeShareCardMethodEvent event, Emitter<ShareCardState> emit) {
    if (event.shareMethodName == 'Scan') {
      emit(ShareCardByScanState());
    } else if (event.shareMethodName == 'Text') {
      emit(ShareCardByTextState());
    } else if (event.shareMethodName == 'Email') {
      emit(ShareCardByEmailState());
    } else if (event.shareMethodName == 'Copy') {
      emit(ShareCardByCopyState());
    }
  }
}
