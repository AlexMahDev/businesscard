import 'package:businesscard/core_ui/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TapFieldBelowWidget extends StatelessWidget {
  const TapFieldBelowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.all(50),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(localText!.infoArea, style: TextThemeCustom.infoAreaTextTheme),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.add, size: 30)
          ],
        ),
      ),
    );
  }
}
