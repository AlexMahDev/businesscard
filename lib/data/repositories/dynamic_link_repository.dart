import 'package:businesscard/data/repositories/card_repository.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import '../../domain/models/card_model.dart';
import '../../presentation/pages/contact_info_page.dart';

class DynamicLinkRepository {

  bool isOpening = false;

  Future<void> retrieveDynamicLink(BuildContext context) async {

    final navigator = Navigator.of(context);

    try {
      final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
      if (data != null) {
        final Uri deepLink = data.link;
        handleDynamicLink(navigator, deepLink);
      }
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {

        // TODO: FIXED BUG WITH FIREBASE: FirebaseDynamicLinks fired multiple times
        if (isOpening == false){
          isOpening = true;
          await handleDynamicLink(navigator, dynamicLinkData.link);
          isOpening = false;
        }

      }).onError((error) {

      });
    } catch (_) {}

  }


  Future<void> handleDynamicLink(NavigatorState navigator, Uri url) async {

    List<String> separatedString = [];
    separatedString.addAll(url.path.split('/'));
    if(separatedString.length == 3) {
      final String uid = separatedString[1];
      final String cardId = separatedString[2];

      try {
        final CardModel? card = await CardRepository().getCard(uid, cardId);
        if(card != null) {
          navigator.push(MaterialPageRoute (
            builder: (BuildContext context) => ContactInfoPage(card: card, isNewCard: true),
          ));
        }
      } catch (_) {}


    }


  }


  Future<CardModel?> handleDynamicLinkManual(Uri url) async {

    List<String> separatedString = [];
    separatedString.addAll(url.path.split('/'));
    if(separatedString.length == 3) {
      final String uid = separatedString[1];
      final String cardId = separatedString[2];

      try {
        final CardModel? card = await CardRepository().getCard(uid, cardId);
        return card;
      } catch (_) {}

    }
    return null;

  }

  Future<ShortDynamicLink?> createDynamicLink(String uid, String cardId) async {

    final ShortDynamicLink dynamicLink;

    final DynamicLinkParameters dynamicLinkParams =
    DynamicLinkParameters(
      uriPrefix: 'https://alexmahdev.page.link',
      link: Uri.parse('https://alexmahdev.page.link/$uid/$cardId'),
      androidParameters: AndroidParameters(
        packageName: 'by.alexmahdev.bcard',
        fallbackUrl: Uri.parse('https://github.com/AlexMahDev/businesscard'),
      ),
      iosParameters: IOSParameters(
        bundleId: 'by.alexmahdev.bcard',
        fallbackUrl: Uri.parse('https://github.com/AlexMahDev/businesscard'),
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: "BCard",
        imageUrl: Uri.parse("https://firebasestorage.googleapis.com/v0/b/bcard-f4f4b.appspot.com/o/dynamic-link%2Fpreview.png?alt=media&token=1b1aa88b-cef2-4ec3-90ee-845d978e1977"),
      ),
    );

    try {
      dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
      return dynamicLink;
    } catch (e) {
      throw Exception(e);
    }


  }




}