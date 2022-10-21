import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/blocs/select_card_color_bloc/select_card_color_bloc.dart';
import '../../presentation/blocs/text_field_bloc/text_field_bloc.dart';
import '../ui_functions/ui_functions.dart';
import 'custom_text_field_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExtraInfoFieldsWidget extends StatelessWidget {
  final Map<String, TextEditingController> controllerMap;

  const ExtraInfoFieldsWidget({Key? key, required this.controllerMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context);

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
                        inputPattern: UiFunctions().getInputPattern(
                            controllerMap.keys.elementAt(index)),
                        controller: UiFunctions().getControllerOf(
                            controllerMap.keys.elementAt(index), controllerMap),
                        hintText:
                            UiFunctions().getHintText(controllerMap.keys.elementAt(index), localText!),
                        icon: UiFunctions().getIcon(controllerMap.keys.elementAt(index)),
                        onTextFieldRemove: () {
                          controllerMap
                              .remove(controllerMap.keys.elementAt(index));
                          final textFieldBloc =
                              BlocProvider.of<TextFieldBloc>(context);
                          textFieldBloc.add(AddTextFieldEvent());
                        },
                        validator: (text) {
                          if (text == '') {
                            return "${UiFunctions().getHintText(controllerMap.keys.elementAt(index), localText)} ${localText.isRequired}";
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
