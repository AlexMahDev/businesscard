
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/select_card_color_bloc/select_card_color_bloc.dart';


class ChooseColorWidget extends StatelessWidget {
  const ChooseColorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectCardColorBloc, int>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ColorWidget(color: 4294922834), //Colors.redAccent
                ColorWidget(color: 4294940672), //Colors.orange
                ColorWidget(color: 4294961979), //Colors.yellow
                ColorWidget(color: 4286141768), //Colors.brown
                ColorWidget(color: 4283215696), //Colors.green
                ColorWidget(color: 4282434815), //Colors.lightBlueAccent
                ColorWidget(color: 4280391411), //Colors.blue
                ColorWidget(color: 4288423856), //Colors.purple
                ColorWidget(color: 4292886779), //Colors.purpleAccent
                ColorWidget(color: 4278190080), //Colors.black
                ColorWidget(color: 4288585374) //Colors.grey
              ],
            ),
          ),
        );
      },
    );
  }
}

class ColorWidget extends StatelessWidget {

  final int color;

  const ColorWidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectCardColor = BlocProvider.of<SelectCardColorBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: () {
          selectCardColor.add(SelectCardColorEvent(color));
        },
        child: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            //color: Colors.redAccent,
            shape: BoxShape.circle,
            border: Border.all(
                color: selectCardColor.state == color
                    ? Colors.grey
                    : Colors.transparent,
                width: 2),
          ),
          child: Center(
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: Color(color),
                shape: BoxShape.circle,
                //border: Border.all(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}