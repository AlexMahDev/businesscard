import 'package:businesscard/blocs/card_page_bloc/card_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_bottom_sheet.dart';



class CustomFloatActionButton extends StatelessWidget {

  final int color;

  const CustomFloatActionButton({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FloatingActionButton.extended(
      elevation: 5,
      extendedPadding: EdgeInsets.symmetric(horizontal: 25),
      backgroundColor: Color(color),
        icon: Icon(Icons.send),
        label: Text('Send', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return FractionallySizedBox(
                  heightFactor: 0.9,
                  child: CustomBottomSheet(),
                );
              });
        }
    );
  }
}
