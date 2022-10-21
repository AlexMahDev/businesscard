import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../domain/models/card_model.dart';
import '../ui_functions/ui_functions.dart';
import 'extra_text_widget.dart';
import 'general_text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardWidget extends StatelessWidget {
  final CardModel card;

  const CardWidget({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: QrImage(
              data: card.qrLink,
              version: QrVersions.auto,
              size: 250,
              gapless: false,
              errorStateBuilder: (cxt, err) {
                return Container();
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomRight,
            children: [
              Column(
                children: [
                  if (card.generalInfo.logoImage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Image.network(card.generalInfo.logoImage,
                          height: 200, errorBuilder: (BuildContext context,
                              Object exception, StackTrace? stackTrace) {
                        return Container();
                      }),
                    ),
                  Divider(
                    color: Color(card.settings.cardColor).withOpacity(0.2),
                    thickness: 5,
                  ),
                ],
              ),
              if (card.generalInfo.profileImage.isNotEmpty)
                Positioned(
                  bottom: -30,
                  right: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipOval(
                        child: Image.network(card.generalInfo.profileImage,
                            width: 80, height: 80, fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                          return Container();
                        }),
                      ),
                    ],
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (card.generalInfo.firstName.isNotEmpty ||
                    card.generalInfo.middleName.isNotEmpty ||
                    card.generalInfo.lastName.isNotEmpty)
                  GeneralTextWidget(
                      label: 'fullName',
                      value:
                          '${card.generalInfo.firstName} ${card.generalInfo.middleName} ${card.generalInfo.lastName}'
                              .trim()),
                if (card.generalInfo.jobTitle.isNotEmpty)
                  GeneralTextWidget(value: card.generalInfo.jobTitle),
                if (card.generalInfo.department.isNotEmpty)
                  GeneralTextWidget(value: card.generalInfo.department),
                if (card.generalInfo.companyName.isNotEmpty)
                  GeneralTextWidget(value: card.generalInfo.companyName),
                if (card.generalInfo.headLine.isNotEmpty)
                  GeneralTextWidget(
                      label: 'headline', value: card.generalInfo.headLine),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: card.extraInfo.listOfFields.length,
            itemBuilder: (BuildContext context, int index) {
              return ExtraTextWidget(
                  label: UiFunctions().getHintText(card.extraInfo.listOfFields[index].key, localText!),
                  value: card.extraInfo.listOfFields[index].value,
                  color: card.settings.cardColor,
                  icon: UiFunctions().getIcon(card.extraInfo.listOfFields[index].key));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10),
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
