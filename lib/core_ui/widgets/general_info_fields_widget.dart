import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/blocs/full_name_dropdown_bloc/full_name_dropdown_bloc.dart';
import 'custom_text_field_widget.dart';

class GeneralInfoFieldsWidget extends StatelessWidget {
  final CustomTextField fullName;
  final CustomTextField firstName;
  final CustomTextField middleName;
  final CustomTextField lastName;
  final CustomTextField jobTitle;
  final CustomTextField department;
  final CustomTextField companyName;
  final CustomTextField headLine;

  const GeneralInfoFieldsWidget(
      {Key? key,
      required this.fullName,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.jobTitle,
      required this.department,
      required this.companyName,
      required this.headLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              final fullNameDropdownBloc =
                  BlocProvider.of<FullNameDropdownBloc>(context);

              final fullNameDropdownState = fullNameDropdownBloc.state;

              if (fullNameDropdownState is FullNameDropdownCloseState) {
                fullNameDropdownBloc.add(FullNameDropdownOpenEvent());
              } else {
                fullNameDropdownBloc.add(FullNameDropdownCloseEvent());
              }
            },
            child: Row(
              children: [
                Expanded(
                  child: fullName,
                ),
                const SizedBox(
                  width: 20,
                ),
                BlocBuilder<FullNameDropdownBloc, FullNameDropdownState>(
                  builder: (context, state) {
                    if (state is FullNameDropdownOpenState) {
                      return const Icon(Icons.keyboard_arrow_up,
                          size: 50, color: Colors.redAccent);
                    }
                    if (state is FullNameDropdownCloseState) {
                      return const Icon(Icons.keyboard_arrow_down,
                          size: 50, color: Colors.redAccent);
                    }

                    return Container();
                  },
                )
              ],
            ),
          ),
          BlocBuilder<FullNameDropdownBloc, FullNameDropdownState>(
            builder: (context, state) {
              if (state is FullNameDropdownOpenState) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: Column(
                    children: [
                      firstName,
                      const SizedBox(
                        height: 15,
                      ),
                      middleName,
                      const SizedBox(
                        height: 15,
                      ),
                      lastName,
                    ],
                  ),
                );
              }

              return Container();
            },
          ),
          const SizedBox(
            height: 15,
          ),
          jobTitle,
          const SizedBox(
            height: 15,
          ),
          department,
          const SizedBox(
            height: 15,
          ),
          companyName,
          const SizedBox(
            height: 15,
          ),
          headLine
        ],
      ),
    );
  }
}
