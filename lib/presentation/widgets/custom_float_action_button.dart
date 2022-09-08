import 'package:flutter/material.dart';



class CustomFloatActionButton extends StatelessWidget {
  const CustomFloatActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: 5,
      extendedPadding: EdgeInsets.symmetric(horizontal: 25),
      backgroundColor: Colors.black,
        icon: Icon(Icons.send),
        label: Text('Send', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        onPressed: () {

        }
    );
  }
}
