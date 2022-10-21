import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../domain/models/card_model.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';



class UiFunctions {

  String getHintText(String key, AppLocalizations localText) {
    if (key == 'phoneNumber') {
      return localText.phoneNumber;
    } else if (key == 'email') {
      return localText.email;
    } else if (key == 'link') {
      return localText.link;
    } else if (key == 'linkedIn') {
      return localText.linkedIn;
    } else if (key == 'gitHub') {
      return localText.gitHub;
    } else if (key == 'telegram') {
      return localText.telegram;
    } else {
      return '';
    }
  }


  Widget getIcon(String key) {
    if (key == 'phoneNumber') {
      return const Icon(Icons.phone, color: Colors.white);
    } else if (key == 'email') {
      return const Icon(Icons.email, color: Colors.white);
    } else if (key == 'link') {
      return const Icon(Icons.link, color: Colors.white);
    } else if (key == 'linkedIn') {
      return Image.asset('assets/images/icons/linkedin-icon.png',
          color: Colors.white, height: 20);
    } else if (key == 'gitHub') {
      return Image.asset('assets/images/icons/github-icon.png',
          color: Colors.white, height: 20);
    } else if (key == 'telegram') {
      return const Icon(Icons.telegram, color: Colors.white);
    } else {
      return const Icon(Icons.add_circle_outline_rounded, color: Colors.white);
    }
  }

  String? getInputPattern(String key) {
    if (key == 'phoneNumber') {
      return r'[+0-9]';
    } else {
      return null;
    }
  }

  TextEditingController getControllerOf(String name, Map<String, TextEditingController> controllerMap) {
    var controller = controllerMap[name];
    if (controller == null) {
      controller = TextEditingController();
      controllerMap[name] = controller;
    }
    return controller;
  }

  String getSubTitle(CardModel card) {
    String subTitle = '';

    if (card.generalInfo.jobTitle.isNotEmpty) {
      subTitle += '${card.generalInfo.jobTitle}, ';
    }

    if (card.generalInfo.department.isNotEmpty) {
      subTitle += '${card.generalInfo.department}, ';
    }

    if (card.generalInfo.companyName.isNotEmpty) {
      subTitle += '${card.generalInfo.companyName}, ';
    }

    if (subTitle.length > 1) {
      subTitle = subTitle.substring(0, subTitle.length - 2);
    }

    return subTitle;
  }

  Future<void> onTap(String label, String value) async {
    if (label == 'Phone Number') {
      final Uri launchUri = Uri(scheme: 'tel', path: value);

      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      }
    } else if (label == 'Email') {
      final Uri emailUri = Uri(scheme: 'mailto', path: value);

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      }
    } else if (label == 'Telegram') {
      String url = value;

      if (!value.contains('http')) {
        url = 'https://t.me/${value.replaceFirst('@', '')}';
        if (await canLaunchUrlString(url)) {
          await launchUrlString(url, mode: LaunchMode.externalApplication);
        }
      } else {
        if (await canLaunchUrlString(url)) {
          await launchUrlString(url, mode: LaunchMode.externalApplication);
        }
      }
    } else {
      if (await canLaunchUrlString(value)) {
        await launchUrlString(value);
      }
    }
  }

  TextStyle getTextStyle(final String label) {
    if (label == "fullName") {
      return const TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
    } else if (label == "headline") {
      return const TextStyle(fontSize: 18, color: Colors.grey);
    } else {
      return const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
    }
  }

}

