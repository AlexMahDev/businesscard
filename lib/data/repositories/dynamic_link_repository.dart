

import 'package:businesscard/data/models/contact_model.dart';
import 'package:businesscard/data/repositories/card_repository.dart';
import 'package:businesscard/data/repositories/contact_repository.dart';
import 'package:businesscard/presentation/widgets/card_widget.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../presentation/contact_info_page.dart';
import '../../presentation/test_page.dart';
import '../models/card_model.dart';

class DynamicLinkRepository {


  Future<void> retrieveDynamicLink(BuildContext context) async {

    final navigator = Navigator.of(context);
    bool isOpening = false;

    try {
      final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
      if (data != null) {
        print('first link check');
        final Uri deepLink = data.link;
        handleDynamicLink(navigator, deepLink);
      }
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {

        //FIXED BUG WITH FIREBASE: FirebaseDynamicLinks fired multiple times
        if (isOpening == false){
          isOpening = true;
          await handleDynamicLink(navigator, dynamicLinkData.link);
          isOpening = false;
        }
        // Navigator.of(context).push(MaterialPageRoute (
        //   builder: (BuildContext context) => const TestPage(),
        // ));
        //Navigator.pushNamed(context, dynamicLinkData.link.path);
      }).onError((error) {
        // Handle errors
      });
    } catch (e) {
      print(e.toString());
    }

  }


  Future<void> handleDynamicLink(NavigatorState navigator, Uri url) async {

    print(url.path);
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

      // ContactRepository contactRepository = ContactRepository();
      // try {
      //   print('gggg1');
      //   final CardModel? card = await contactRepository.saveContact(uid, cardId);
      //   if(card != null) {
      //     print('gggg2');
      //     navigator.push(MaterialPageRoute (
      //       builder: (BuildContext context) => ContactInfoPage(card: card),
      //     ));
      //   }
      // } catch (_) {}

    }


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
        //appStoreId: '962194608',
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