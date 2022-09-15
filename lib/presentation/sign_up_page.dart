import 'package:businesscard/presentation/cards_page.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:businesscard/presentation/widgets/custom_text_field_widget.dart';
import 'package:businesscard/presentation/widgets/loading_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            splashRadius: 20,
            onPressed: () {
              Navigator.pop(context);
            },
          )
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is Loading) {
            loadingOverlay.show(context);
          } else {
            loadingOverlay.hide();
          }
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const CardsPage(),
              ),
            );
          }
          if (state is AuthError) {
            // Displaying the error message if the user is not authenticated
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
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
                    Text("Welcome, let's sign up",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 40,
                    ),
                    CustomTextField(controller: email, hintText: "Email", validator: (text) {
                      if(text == '') {
                        return "Email is required";
                      } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text!)) {
                        return "Enter valid email";
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(controller: password, hintText: "Password", isTextVisible: false, validator: (text) {
                      if(text == '') {
                        return "Password is required";
                      } else if (text!.length < 8) {
                        return "Your password is too short";
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        controller: confirmPassword, hintText: "Confirm password", isTextVisible: false, validator: (text) {
                      if(text == '') {
                        return "Confirm password";
                      } else if (password.text != text) {
                        return "Check your password";
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        if(_validation.currentState!.validate()) {
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
                          child: Text("Create your card",
                              style: TextStyle(
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
