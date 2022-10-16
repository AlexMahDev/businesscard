import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../domain/models/card_model.dart';

class CardWidget extends StatelessWidget {
  final CardModel card;

  const CardWidget({Key? key, required this.card}) : super(key: key);

  String getHintText(String key) {
    if (key == 'phoneNumber') {
      return 'Phone Number';
    } else if (key == 'email') {
      return 'Email';
    } else if (key == 'link') {
      return 'Link';
    } else if (key == 'linkedIn') {
      return 'LinkedIn';
    } else if (key == 'gitHub') {
      return 'GitHub';
    } else if (key == 'telegram') {
      return 'Telegram';
    } else {
      return '';
    }
  }

  Widget getIcon(String key) {
    if (key == 'phoneNumber') {
      return Icon(Icons.phone, color: Colors.white);
    } else if (key == 'email') {
      return Icon(Icons.email, color: Colors.white);
    } else if (key == 'link') {
      return Icon(Icons.link, color: Colors.white);
    } else if (key == 'linkedIn') {
      return Image.asset('assets/images/icons/linkedin-icon.png',
          color: Colors.white, height: 20);
    } else if (key == 'gitHub') {
      return Image.asset('assets/images/icons/github-icon.png',
          color: Colors.white, height: 20);
    } else if (key == 'telegram') {
      return Icon(Icons.telegram, color: Colors.white);
    } else {
      return Icon(Icons.add_circle_outline_rounded, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
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
          SizedBox(
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
          SizedBox(
            height: 10,
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemCount: card.extraInfo.listOfFields.length,
            //padding: EdgeInsets.only(top: 15),
            itemBuilder: (BuildContext context, int index) {
              return ExtraTextWidget(
                  label: getHintText(card.extraInfo.listOfFields[index].key),
                  value: card.extraInfo.listOfFields[index].value,
                  color: card.settings.cardColor,
                  icon: getIcon(card.extraInfo.listOfFields[index].key));
            },
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 10),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}

class GeneralTextWidget extends StatelessWidget {
  final String label;
  final String value;

  const GeneralTextWidget({Key? key, this.label = '', required this.value})
      : super(key: key);

  TextStyle getTextStyle() {
    if (label == "fullName") {
      return TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
    } else if (label == "headline") {
      return TextStyle(fontSize: 18, color: Colors.grey);
    } else {
      return TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(value, style: getTextStyle()),
    );
  }
}

class ExtraTextWidget extends StatelessWidget {
  final String label;
  final String value;
  final int color;
  final Widget icon;

  const ExtraTextWidget(
      {Key? key,
      required this.label,
      required this.value,
      required this.color,
      required this.icon})
      : super(key: key);

  Future<void> onTap() async {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await onTap();
      },
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundColor: Color(color), child: icon),
          Expanded(
            child: ListTile(
              title: Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(label),
            ),
          )
        ],
      ),
    );
  }
}
