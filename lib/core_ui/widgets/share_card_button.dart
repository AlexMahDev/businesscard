import 'package:flutter/material.dart';
import 'custom_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ShareCardButton extends StatelessWidget {
  final String qrLink;
  final int color;

  const ShareCardButton({Key? key, required this.qrLink, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context);
    return FloatingActionButton.extended(
        elevation: 5,
        extendedPadding: const EdgeInsets.symmetric(horizontal: 25),
        backgroundColor: Color(color),
        icon: const Icon(Icons.send),
        label: Text(localText!.send,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.redAccent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return FractionallySizedBox(
                  heightFactor: 0.9,
                  child: CustomBottomSheet(qrLink: qrLink),
                );
              });
        });
  }
}
