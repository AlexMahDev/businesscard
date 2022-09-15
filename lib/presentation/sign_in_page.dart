import 'package:businesscard/presentation/cards_page.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:businesscard/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  late final TextEditingController email;
  late final TextEditingController password;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            splashRadius: 20,
            onPressed: () {
              Navigator.pop(context);
            },
          )
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const CardsPage()));
          }
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {

            if (state is Loading) {
              // Showing the loading indicator while the user is signing in
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              // Showing the sign in form if the user is not authenticated
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome back, let's sign in",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 40,
                    ),
                    CustomTextField(controller: email, hintText: "Email"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(controller: password, hintText: "Password"),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (BuildContext context) =>
                        //       // BlocProvider.value(
                        //       //   value: BlocProvider.of<AuthPageBloc>(context)..add(SignInEvent()),
                        //       //   child: AuthPage(),
                        //       // ),
                        // ));
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (BuildContext context) => const AuthPage(),
                        //   ),
                        // );
                      },
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text("Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16)),
                        ),
                      ),
                    ),

                  ],
                ),
              );
            }
                  //return Container();
            return Container();
          },
        ),
      ),
    );
  }
}

