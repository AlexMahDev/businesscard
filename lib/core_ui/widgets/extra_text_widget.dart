import 'package:businesscard/core_ui/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../ui_functions/ui_functions.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await UiFunctions().onTap(label, value);
      },
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundColor: Color(color), child: icon),
          Expanded(
            child: ListTile(
              title: Text(value,
                  style: TextThemeCustom.extraInfoTextTheme),
              subtitle: Text(label),
            ),
          )
        ],
      ),
    );
  }
}
