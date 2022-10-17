import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/contact_model.dart';
import '../../presentation/blocs/contact_bloc/contact_bloc.dart';
import 'custom_text_field_widget.dart';

class AddContactByLinkWidget extends StatefulWidget {
  final List<ContactModel> contacts;

  const AddContactByLinkWidget({Key? key, required this.contacts})
      : super(key: key);

  @override
  State<AddContactByLinkWidget> createState() => _AddContactByLinkWidgetState();
}

class _AddContactByLinkWidgetState extends State<AddContactByLinkWidget> {
  late final TextEditingController urlController;
  final _validation = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    urlController = TextEditingController();
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _validation,
      child: AlertDialog(
        title: const Text("Add contact"),
        content: SizedBox(
          width: 400,
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Enter link you received from contact"),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: CustomTextField(
                    controller: urlController,
                    hintText: "Link",
                    validator: (text) {
                      if (text == '') {
                        return "URL is required";
                      } else if (!RegExp(
                              r"^https:\/\/alexmahdev\.page\.link\/\b")
                          .hasMatch(text!)) {
                        return "Enter valid URL";
                      }
                      return null;
                    }),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                if (_validation.currentState!.validate()) {
                  Navigator.pop(context);
                  BlocProvider.of<ContactBloc>(context).add(
                      SaveContactManualEvent(
                          urlController.text, widget.contacts));
                }
              },
              child: const Text('Add', style: TextStyle(fontSize: 18))),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle(fontSize: 18))),
        ],
      ),
    );
  }
}
