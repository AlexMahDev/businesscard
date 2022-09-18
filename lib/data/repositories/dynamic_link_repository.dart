

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
        //print('second link check');
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


}