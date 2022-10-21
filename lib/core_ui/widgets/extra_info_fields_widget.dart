import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/blocs/select_card_color_bloc/select_card_color_bloc.dart';
import '../../presentation/blocs/text_field_bloc/text_field_bloc.dart';
import 'custom_text_field_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExtraInfoFieldsWidget extends StatelessWidget {
  final Map<String, TextEditingController> controllerMap;

  const ExtraInfoFieldsWidget({Key? key, required this.controllerMap})
      : super(key: key);

  TextEditingController _getControllerOf(String name) {
    var controller = controllerMap[name];
    if (controller == null) {
      controller = TextEditingController();
      controllerMap[name] = controller;
    }
    return controller;
  }

  Widget getIcon(String key) {
    if (key == 'phoneNumber') {
      return const Icon(Icons.phone, color: Colors.white);
    } else if (key == 'email') {
      return const Icon(Icons.email, color: Colors.white);
    } else if (key == 'link') {
      return const Icon(Icons.link, color: Colors.white);
    } else if (key == 'linkedIn') {
      return Image.asset('assets/images/icons/linkedin-icon.png',
          color: Colors.white, height: 20);
    } else if (key == 'gitHub') {
      return Image.asset('assets/images/icons/github-icon.png',
          color: Colors.white, height: 20);
    } else if (key == 'telegram') {
      return const Icon(Icons.telegram, color: Colors.white);
    } else {
      return const Icon(Icons.add_circle_outline_rounded, color: Colors.white);
    }
  }

  String? getInputPattern(String key) {
    if (key == 'phoneNumber') {
      return r'[+0-9]';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context);
    String getHintText(String key) {
      if (key == 'phoneNumber') {
        return localText!.phoneNumber;
      } else if (key == 'email') {
        return localText!.email;
      } else if (key == 'link') {
        return localText!.link;
      } else if (key == 'linkedIn') {
        return localText!.linkedIn;
      } else if (key == 'gitHub') {
        return localText!.gitHub;
      } else if (key == 'telegram') {
        return localText!.telegram;
      } else {
        return '';
      }
    }
    return BlocBuilder<SelectCardColorBloc, int>(
      builder: (context, state) {
        return BlocBuilder<TextFieldBloc, TextFieldState>(
          builder: (context, state) {
            if (state is TextFieldInitialState && controllerMap.isNotEmpty) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controllerMap.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomTextField(
                        inputPattern: getInputPattern(
                            controllerMap.keys.elementAt(index)),
                        controller: _getControllerOf(
                            controllerMap.keys.elementAt(index)),
                        hintText:

                            getHintText(controllerMap.keys.elementAt(index)),
                        icon: getIcon(controllerMap.keys.elementAt(index)),
                        onTextFieldRemove: () {
                          controllerMap
                              .remove(controllerMap.keys.elementAt(index));
                          final textFieldBloc =
                              BlocProvider.of<TextFieldBloc>(context);
                          textFieldBloc.add(AddTextFieldEvent());
                        },
                        validator: (text) {
                          if (text == '') {
                            return "${getHintText(controllerMap.keys.elementAt(index))} ${localText!.isRequired}";
                          }
                          return null;
                        });
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 15),
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
