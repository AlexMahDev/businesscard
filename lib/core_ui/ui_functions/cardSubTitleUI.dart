import '../../domain/models/card_model.dart';

class SubTitleUI {
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
}
