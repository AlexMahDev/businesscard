
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/blocs/select_card_color_bloc/select_card_color_bloc.dart';
import 'color_widget.dart';




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
