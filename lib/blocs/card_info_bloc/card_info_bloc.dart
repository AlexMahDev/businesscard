import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:businesscard/data/models/card_model.dart';
import 'package:businesscard/data/repositories/card_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'card_info_event.dart';
part 'card_info_state.dart';

class CardInfoBloc extends Bloc<CardInfoEvent, CardInfoState> {

  final CardRepository cardRepository;

  CardInfoBloc({required this.cardRepository}) : super(CardInfoInitialState()) {
    on<GetCardInfoEvent>(_getCardInfo);
    on<AddCardEvent>(_addCard);
    on<AddExtraInfoEvent>(_addExtraInfo);
  }

  _getCardInfo(CardInfoEvent event, Emitter<CardInfoState> emit) async {

    emit(CardInfoLoadingState());

    final user = FirebaseAuth.instance.currentUser!;

    // await Future.delayed(const Duration(seconds: 5), () {});
    //
    // List<Map<String, dynamic>> listOfCards = [
    //
    //   {
    //     "cardId": 1,
    //     "settings": {
    //       //"cardTitle": "Job",
    //       "cardColor": 4294922834,
    //     },
    //     "generalInfo": {
    //       "cardTitle": "Job",
    //       "firstName": "Alexander",
    //       "middleName": "Mikhailovich",
    //       "lastName": "Makhrachyov",
    //       "jobTitle": "Head Of Mobile",
    //       "department": "Mobile",
    //       "companyName": "Innowise",
    //       "headLine": "Hi!",
    //       "profileImage": "https://broncolor.swiss/assets/img/Stories/Inspiration/Daniel-Radcliffe/_contentWithShareBar23/DANIEL-RADCLIFFE-featured.jpg",
    //       "logoImage": ""
    //     },
    //     "extraInfo": {
    //       "email": "myemail@gmail.com",
    //     },
    //
    //   },
    //
    //   {
    //     "cardId": 2,
    //     "settings": {
    //       "cardColor": 4294922834,
    //     },
    //     "generalInfo": {
    //       "cardTitle": "Job",
    //       "firstName": "Alexander",
    //       "middleName": "Mikhailovich",
    //       "lastName": "test",
    //       "jobTitle": "test",
    //       "department": "Mobile",
    //       "companyName": "test",
    //       "headLine": "Hi!",
    //       "profileImage": "https://broncolor.swiss/assets/img/Stories/Inspiration/Daniel-Radcliffe/_contentWithShareBar23/DANIEL-RADCLIFFE-featured.jpg",
    //       "logoImage": "https://scontent-waw1-1.xx.fbcdn.net/v/t39.30808-6/215485554_10159431724164660_8100659849944415055_n.png?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=WUhRQ7j_fr8AX-aIi3O&_nc_ht=scontent-waw1-1.xx&oh=00_AT8EUagE3wtnp-EPMVpVE9x9GTcrmOsITCKpNEXC7zzVtA&oe=632456A9"
    //     },
    //     "extraInfo": {
    //       "email": "test@gmail.com",
    //     },
    //
    //   }
    //
    // ];
    //
    //
    // List<CardModel> cards = List.from(listOfCards.map((card) => CardModel.fromJson(card)));


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



    //CardModel card = CardModel.fromJson(listOfCards[0]);



    // Map<String, Map<String, String>> data =
    //
    // {
    //   "generalInfo": {
    //     "Full_Name": "Alexander Makhrachyov",
    //     "Job_Title": "Head Of Mobile",
    //     "Department": "Mobile",
    //     "Company_Name": "Innowise",
    //     "Headline": "Hi!"
    //   },
    //   "extraInfo": {
    //     "Email": "myemail@gmail.com",
    //   },
    //
    // };


  }


  _addCard(AddCardEvent event, Emitter<CardInfoState> emit) async {

    emit(CardInfoLoadingState());

    final user = FirebaseAuth.instance.currentUser!;

    try {
      await cardRepository.createCard(user.uid, event.newCard);
      List<CardModel> cards = event.cards;
      cards.add(event.newCard);
      emit(CardInfoLoadedState(cards));
    } catch (e) {
      emit(CardInfoErrorState());
    }

    //List<CardModel> cards = List.from(listOfCards.map((card) => CardModel.fromJson(card)));


  }

  _addExtraInfo(AddExtraInfoEvent event, Emitter<CardInfoState> emit) async {


    //List<CardModel> cards = List.from(listOfCards.map((card) => CardModel.fromJson(card)));

    emit(CardInfoLoadedState(event.cards));

  }


}
