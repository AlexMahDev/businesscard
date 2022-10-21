import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/contact_model.dart';
import '../../presentation/blocs/contact_bloc/contact_bloc.dart';
import 'custom_text_field_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AddContactByLinkWidget extends StatefulWidget {
  const AddContactByLinkWidget({Key? key}) : super(key: key);

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
    final localText = AppLocalizations.of(context);
    return Form(
      key: _validation,
      child: AlertDialog(
        title: Text(localText!.addContact),
        content: SizedBox(
          width: 400,
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(localText.enterLink),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: CustomTextField(
                    controller: urlController,
                    hintText: localText.link,
                    validator: (text) {
                      if (text == '') {
                        return "${localText.url} ${localText.isRequired}";
                      } else if (!RegExp(
                              r"^https:\/\/alexmahdev\.page\.link\/\b")
                          .hasMatch(text!)) {
                        return localText.enterValidUrl;
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
                  final contactBloc = BlocProvider.of<ContactBloc>(context);
                  final contactState = contactBloc.state;
                  Navigator.pop(context);
                  if (contactState is ContactLoadedState) {
                    final List<ContactModel> contacts = contactState.contacts;
                    BlocProvider.of<ContactBloc>(context).add(
                        SaveContactManualEvent(urlController.text, contacts));
                  } else if (contactState is ContactSearchState) {
                    final List<ContactModel> contacts = contactState.contacts;
                    final List<ContactModel> foundContacts =
                        contactState.foundContacts;
                    BlocProvider.of<ContactBloc>(context).add(
                        SaveContactManualEvent(
                            urlController.text, contacts, foundContacts));
                  }
                }
              },
              child: Text(localText.open, style: const TextStyle(fontSize: 18))),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(localText.cancel, style: const TextStyle(fontSize: 18))),
        ],
      ),
    );
  }
}
