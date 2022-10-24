import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HintTextUI {
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
}
