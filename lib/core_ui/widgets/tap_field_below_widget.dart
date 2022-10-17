import 'package:flutter/material.dart';

class TapFieldBelowWidget extends StatelessWidget {
  const TapFieldBelowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tap a field below to add it',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.add, size: 30)
          ],
        ),
      ),
    );
  }
}
