
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/select_card_color_bloc/select_card_color_bloc.dart';
import '../../blocs/text_clear_button_bloc/text_clear_button_bloc.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool enabled;

  final Widget? icon;
  final VoidCallback? onTextFieldRemove;

  const CustomTextField({Key? key,
    required this.controller,
    required this.hintText,
    this.enabled = true,
    this.icon,
    this.onTextFieldRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColorBloc = BlocProvider.of<SelectCardColorBloc>(context);

    return BlocProvider<TextClearButtonBloc>(
      create: (context) => TextClearButtonBloc(),
      child: Builder(builder: (context) {
        return Row(
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(cardColorBloc.state),
                    child: icon),
              ),
            Expanded(
              child: TextFormField(
                controller: controller,
                enabled: enabled,
                decoration: InputDecoration(
                  //contentPadding: EdgeInsets.all(0),
                  suffixIcon:
                  BlocBuilder<TextClearButtonBloc, TextClearButtonState>(
                    builder: (context, state) {
                      if (state is ClearButtonEnableState) {
                        return IconButton(
                          onPressed: () {
                            controller.clear();
                            final clearButtonBloc =
                            BlocProvider.of<TextClearButtonBloc>(context);
                            clearButtonBloc.add(ClearButtonDisableEvent());
                          },
                          icon: Icon(Icons.highlight_remove_outlined),
                          splashRadius: 20,
                        );
                      }

                      return SizedBox();
                    },
                  ),
                  hintText: hintText,
                  //labelText: 'Name *',
                ),
                onTap: () {
                  if (controller.text.isNotEmpty) {
                    final clearButtonBloc =
                    BlocProvider.of<TextClearButtonBloc>(context);
                    clearButtonBloc.add(ClearButtonEnableEvent());
                  }
                },
                onChanged: (text) {
                  if (controller.text.isEmpty) {
                    final clearButtonBloc =
                    BlocProvider.of<TextClearButtonBloc>(context);
                    clearButtonBloc.add(ClearButtonDisableEvent());
                  } else if (controller.text.length == 1) {
                    final clearButtonBloc =
                    BlocProvider.of<TextClearButtonBloc>(context);
                    clearButtonBloc.add(ClearButtonEnableEvent());
                  }
                },
                //textAlign: TextAlign.center,
              ),
            ),
            if (icon != null)
              IconButton(
                  splashRadius: 20,
                  onPressed: onTextFieldRemove,
                  icon: Icon(Icons.remove_circle_outline))
          ],
        );
      }),
    );
  }
}