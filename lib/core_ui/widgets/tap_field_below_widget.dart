import 'package:flutter/material.dart';

class TapFieldBelowWidget extends StatelessWidget {
  const TapFieldBelowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(50),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
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
