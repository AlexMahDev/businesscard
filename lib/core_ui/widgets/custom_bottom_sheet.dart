import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../themes/text_theme.dart';

class CustomBottomSheet extends StatelessWidget {
  final String qrLink;

  const CustomBottomSheet({Key? key, required this.qrLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  splashRadius: 20,
                  icon: const Icon(Icons.close, color: Colors.white, size: 35)),
              Center(
                  child: Text(localText!.myCard,
                      style: TextThemeCustom.myCardTextTheme)),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Share.share('${localText.findMyCardByLink} $qrLink');
                  },
                  splashRadius: 20,
                  icon: const Icon(Icons.ios_share,
                      color: Colors.white, size: 30)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 250,
                  margin: const EdgeInsets.all(40),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                  child: QrImage(
                    data: qrLink,
                    version: QrVersions.auto,
                    //size: 250,
                    gapless: false,
                    errorStateBuilder: (cxt, err) {
                      return Container();
                    },
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(localText.useCameraToReceiveTheCard,
                    style: TextThemeCustom.useCameraTextTheme,
                    textAlign: TextAlign.center),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 80,
        )
      ],
    );
  }
}
