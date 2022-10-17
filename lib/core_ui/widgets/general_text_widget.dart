import 'package:flutter/material.dart';

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
