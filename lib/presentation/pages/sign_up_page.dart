import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core_ui/widgets/custom_app_bar.dart';
import '../../core_ui/widgets/custom_text_field_widget.dart';
import '../../core_ui/widgets/loading_overlay_widget.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import 'main_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController confirmPassword;
  late final LoadingOverlay loadingOverlay;
  final _validation = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    loadingOverlay = LoadingOverlay();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          leading: IconButton(
        icon: const Icon(Icons.close),
        splashRadius: 20,
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Loading) {
            loadingOverlay.show(context);
          } else {
            loadingOverlay.hide();
          }
          if (state is Authenticated) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MainPage()),
                (route) => false);
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(localText!.errorText)));
          }
        },
        builder: (context, state) {
          return Form(
            key: _validation,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(localText!.welcomeSignUp,
                      style:
                          const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextField(
                      controller: email,
                      hintText: localText.email,
                      validator: (text) {
                        if (text == '') {
                          return '${localText.email} ${localText.isRequired}';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text!)) {
                          return localText.enterValidEmail;
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      controller: password,
                      hintText: localText.password,
                      isTextVisible: false,
                      validator: (text) {
                        if (text == '') {
                          return '${localText.password} ${localText.isRequired}';
                        } else if (text!.length < 8) {
                          return localText.passwordIsShort;
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      controller: confirmPassword,
                      hintText: localText.confirmPassword,
                      isTextVisible: false,
                      validator: (text) {
                        if (text == '') {
                          return localText.confirmPassword;
                        } else if (password.text != text) {
                          return localText.checkPassword;
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_validation.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                          SignUpRequested(email.text, password.text),
                        );
                      }
                    },
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(localText.createYourCardButton,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
