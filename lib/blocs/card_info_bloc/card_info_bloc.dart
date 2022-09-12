import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:businesscard/data/models/card_model.dart';
import 'package:meta/meta.dart';

part 'card_info_event.dart';
part 'card_info_state.dart';

class CardInfoBloc extends Bloc<CardInfoEvent, CardInfoState> {
  CardInfoBloc() : super(CardInfoInitialState()) {
    on<GetCardInfoEvent>(_getCardInfo);
    on<AddCardEvent>(_addCard);
    on<AddExtraInfoEvent>(_addExtraInfo);
  }

  _getCardInfo(CardInfoEvent event, Emitter<CardInfoState> emit) async {

    emit(CardInfoLoadingState());

    await Future.delayed(const Duration(seconds: 5), () {});

    List<Map<String, Map<String, dynamic>>> listOfCards = [

      {
        "settings": {
          //"cardTitle": "Job",
          "cardColor": 4294922834,
        },
        "generalInfo": {
          "cardTitle": "Job",
          "firstName": "Alexander",
          "middleName": "Mikhailovich",
          "lastName": "Makhrachyov",
          "jobTitle": "Head Of Mobile",
          "department": "Mobile",
          "companyName": "Innowise",
          "headLine": "Hi!"
        },
        "extraInfo": {
          "email": "myemail@gmail.com",
        },

      },

      {
        "settings": {
          "cardColor": 4294922834,
        },
        "generalInfo": {
          "cardTitle": "Job",
          "firstName": "Alexander",
          "middleName": "Mikhailovich",
          "lastName": "test",
          "jobTitle": "test",
          "department": "Mobile",
          "companyName": "test",
          "headLine": "Hi!"
        },
        "extraInfo": {
          "email": "test@gmail.com",
        },

      }

    ];


    List<CardModel> cards = List.from(listOfCards.map((card) => CardModel.fromJson(card)));



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

    emit(CardInfoLoadedState(cards));

  }


  _addCard(AddCardEvent event, Emitter<CardInfoState> emit) async {


    //List<CardModel> cards = List.from(listOfCards.map((card) => CardModel.fromJson(card)));

    emit(CardInfoLoadedState(event.cards));

  }

  _addExtraInfo(AddExtraInfoEvent event, Emitter<CardInfoState> emit) async {


    //List<CardModel> cards = List.from(listOfCards.map((card) => CardModel.fromJson(card)));

    emit(CardInfoLoadedState(event.cards));

  }


}
