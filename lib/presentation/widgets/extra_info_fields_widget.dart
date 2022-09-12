import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/select_card_color_bloc/select_card_color_bloc.dart';
import '../../blocs/text_field_bloc/text_field_bloc.dart';
import 'custom_text_field_widget.dart';

class ExtraInfoFieldsWidget extends StatelessWidget {

  final Map<String, TextEditingController> controllerMap;

  const ExtraInfoFieldsWidget({Key? key, required this.controllerMap}) : super(key: key);

  TextEditingController _getControllerOf(String name) {
    var controller = controllerMap[name];
    if (controller == null) {
      controller = TextEditingController();
      controllerMap[name] = controller;
    }
    //print(_controllerMap.length);
    return controller;
  }

  String getHintText(String key) {
    if (key == 'phoneNumber') {
      return 'Phone Number';
    } else if (key == 'email') {
      return 'Email';
    } else if (key == 'link') {
      return 'Link';
    } else if (key == 'linkedIn') {
      return 'LinkedIn';
    } else if (key == 'gitHub') {
      return 'GitHub';
    } else if (key == 'telegram') {
      return 'Telegram';
    } else {
      return '';
    }
  }

  Widget getIcon(String key) {
    if (key == 'phoneNumber') {
      return Icon(Icons.phone, color: Colors.white);
    } else if (key == 'email') {
      return Icon(Icons.email, color: Colors.white);
    } else if (key == 'link') {
      return Icon(Icons.link, color: Colors.white);
    } else if (key == 'linkedIn') {
      return Image.asset('assets/images/icons/linkedin-icon.png',
          color: Colors.white, height: 20);
    } else if (key == 'gitHub') {
      return Image.asset('assets/images/icons/github-icon.png',
          color: Colors.white, height: 20);
    } else if (key == 'telegram') {
      return Icon(Icons.telegram, color: Colors.white);
    } else {
      return Icon(Icons.add_circle_outline_rounded, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectCardColorBloc, Color>(
      builder: (context, state) {
        return BlocBuilder<TextFieldBloc, TextFieldState>(
          builder: (context, state) {
            if (state is TextFieldInitialState &&
                controllerMap.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 30),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controllerMap.length,
                  //padding: EdgeInsets.only(top: 15),
                  itemBuilder: (BuildContext context, int index) {
                    //final controller = _getControllerOf(data[index]);

                    // final textField = TextField(
                    //   controller: controller,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     labelText: "name${index + 1}",
                    //   ),
                    // );
                    return CustomTextField(
                      controller: _getControllerOf(
                          controllerMap.keys.elementAt(index)),
                      hintText: getHintText(
                          controllerMap.keys.elementAt(index)),
                      icon: getIcon(
                          controllerMap.keys.elementAt(index)),
                      onTextFieldRemove: () {
                        controllerMap.remove(
                            controllerMap.keys.elementAt(index));
                        final textFieldBloc = BlocProvider.of<
                            TextFieldBloc>(context);
                        textFieldBloc.add(AddTextFieldEvent());
                      },
                    );
                    //   Container(
                    //   child: TextField(
                    //     controller: _getControllerOf(data.keys.elementAt(index)),
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: data[index],
                    //     ),
                    //   ),
                    //   padding: EdgeInsets.only(bottom: 10),
                    // );
                  },
                  separatorBuilder:
                      (BuildContext context, int index) =>
                      SizedBox(height: 15),
                ),
              );
            }

            return Container();
          },
        );
      },
    );
  }
}
