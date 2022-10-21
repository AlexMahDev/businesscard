import 'package:flutter/material.dart';

import '../ui_functions/ui_functions.dart';

class GeneralTextWidget extends StatelessWidget {
  final String label;
  final String value;

  const GeneralTextWidget({Key? key, this.label = '', required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(value, style: UiFunctions().getTextStyle(label)),
    );
  }
}
