import 'package:bloc/bloc.dart';
import 'package:businesscard/data/repositories/card_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/models/card_model.dart';
import '../card_page_bloc/card_page_bloc.dart';

part 'card_info_event.dart';
part 'card_info_state.dart';

class CardInfoBloc extends Bloc<CardInfoEvent, CardInfoState> {

  final CardRepository cardRepository;
  final CardPageBloc cardPageBloc;

  CardInfoBloc({required this.cardRepository, required this.cardPageBloc}) : super(CardInfoInitialState()) {
    on<GetCardInfoEvent>(_getCardInfo);
    on<AddCardEvent>(_addCard);
    on<UpdateCardEvent>(_updateCard);
    on<DeleteCardEvent>(_deleteCard);
  }

  _getCardInfo(CardInfoEvent event, Emitter<CardInfoState> emit) async {

    emit(CardInfoLoadingState());

    final user = FirebaseAuth.instance.currentUser!;

    try {
      List<CardModel> cards = await cardRepository.getCards(user.uid);
      if(cards.isNotEmpty) {
        emit(CardInfoLoadedState(cards));
      } else {
        emit(CardInfoEmptyState(cards));
      }
    } catch (e) {
      emit(CardInfoErrorState());
    }


  }


  _addCard(AddCardEvent event, Emitter<CardInfoState> emit) async {

    emit(CardInfoLoadingState());
    emit(AddCardLoadingState());

    final user = FirebaseAuth.instance.currentUser!;
    List<CardModel> cards = event.cards;

    try {
      await cardRepository.createCard(user.uid, event.newCard);
      cards.add(event.newCard);
      cardPageBloc.add(ChangeCardPageEvent(cards.length - 1));
      emit(AddCardSuccessState());
    } catch (e) {
      emit(AddCardErrorState());
    }

    if(cards.isNotEmpty) {
      emit(CardInfoLoadedState(cards));
    } else {
      emit(CardInfoEmptyState(cards));
    }


  }

  _updateCard(UpdateCardEvent event, Emitter<CardInfoState> emit) async {

    emit(CardInfoLoadingState());
    emit(UpdateCardLoadingState());

    final user = FirebaseAuth.instance.currentUser!;

    List<CardModel> cards = event.cards;

    try {
      await cardRepository.updateCard(user.uid, event.newCard);
      cards[cards.indexWhere((element) => element.cardId == event.newCard.cardId)] = event.newCard;
      emit(UpdateCardSuccessState());
    } catch (e) {
      emit(UpdateCardErrorState());
    }

    emit(CardInfoLoadedState(cards));


  }

  _deleteCard(DeleteCardEvent event, Emitter<CardInfoState> emit) async {

    emit(CardInfoLoadingState());
    emit(DeleteCardLoadingState());

    final user = FirebaseAuth.instance.currentUser!;

    List<CardModel> cards = event.cards;

    try {
      await cardRepository.deleteCard(user.uid, event.cardId);
      cards.removeAt(cards.indexWhere((element) => element.cardId == event.cardId));
      cardPageBloc.add(ChangeCardPageEvent(0));
      emit(DeleteCardSuccessState());
    } catch (e) {
      emit(DeleteCardErrorState());
    }

    if(cards.isNotEmpty) {
      emit(CardInfoLoadedState(cards));
    } else {
      emit(CardInfoEmptyState(cards));
    }

  }


}
