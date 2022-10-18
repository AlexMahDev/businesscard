import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/blocs/select_card_color_bloc/select_card_color_bloc.dart';
import '../../presentation/blocs/text_clear_button_bloc/text_clear_button_bloc.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool enabled;

  final Widget? icon;
  final VoidCallback? onTextFieldRemove;

  final bool isTextVisible;

  final String? Function(String?)? validator;

  final String? inputPattern;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.enabled = true,
      this.icon,
      this.onTextFieldRemove,
      this.validator,
      this.isTextVisible = true,
      this.inputPattern})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    backgroundColor: Color(
                        BlocProvider.of<SelectCardColorBloc>(context).state),
                    child: icon),
              ),
            Expanded(
              child: FocusScope(
                onFocusChange: (focus) {
                  final clearButtonBloc =
                      BlocProvider.of<TextClearButtonBloc>(context);
                  if (focus) {
                    if (controller.text.isNotEmpty) {
                      clearButtonBloc.add(ClearButtonEnableEvent());
                    }
                  } else {
                    clearButtonBloc.add(ClearButtonDisableEvent());
                  }
                },
                child: TextFormField(
                  inputFormatters: inputPattern != null
                      ? [
                          FilteringTextInputFormatter.allow(
                              RegExp(inputPattern!))
                        ]
                      : null,
                  controller: controller,
                  enabled: enabled,
                  obscureText: !isTextVisible,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.red),
                    suffixIcon:
                        BlocBuilder<TextClearButtonBloc, TextClearButtonState>(
                      builder: (context, state) {
                        if (state is ClearButtonEnableState) {
                          return IconButton(
                            onPressed: () {
                              controller.clear();
                              BlocProvider.of<TextClearButtonBloc>(context)
                                  .add(ClearButtonDisableEvent());
                            },
                            icon: const Icon(Icons.highlight_remove_outlined),
                            splashRadius: 20,
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                    hintText: hintText,
                  ),
                  onChanged: (text) {
                    if (controller.text.isEmpty) {
                      BlocProvider.of<TextClearButtonBloc>(context)
                          .add(ClearButtonDisableEvent());
                    } else if (controller.text.length == 1) {
                      BlocProvider.of<TextClearButtonBloc>(context)
                          .add(ClearButtonEnableEvent());
                    }
                  },
                  validator: validator,
                ),
              ),
            ),
            if (icon != null)
              IconButton(
                  splashRadius: 20,
                  onPressed: onTextFieldRemove,
                  icon: const Icon(Icons.remove_circle_outline))
          ],
        );
      }),
    );
  }
}
