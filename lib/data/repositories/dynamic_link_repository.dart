

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../presentation/test_page.dart';

class DynamicLinkRepository {


  Future<void> retrieveDynamicLink(BuildContext context) async {

    final navigator = Navigator.of(context);

    try {
      final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
      if (data != null) {
        print('first link check');
        final Uri deepLink = data.link;
        handleDynamicLink(navigator, deepLink);
      }
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
        print('second link check');
        handleDynamicLink(navigator, dynamicLinkData.link);
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


  void handleDynamicLink(NavigatorState navigator, Uri url) {

    print(url.path);


    navigator.push(MaterialPageRoute (
      builder: (BuildContext context) => const TestPage(),
    ));


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