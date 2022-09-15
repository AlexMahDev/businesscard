import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:businesscard/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController confirmPassword;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
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
      appBar: CustomAppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            splashRadius: 20,
            onPressed: () {
              Navigator.pop(context);
            },
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome, let's sign up",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 40,
            ),
            CustomTextField(controller: email, hintText: "Email"),
            SizedBox(
              height: 20,
            ),
            CustomTextField(controller: password, hintText: "Password"),
            SizedBox(
              height: 20,
            ),
            CustomTextField(controller: confirmPassword, hintText: "Confirm password"),
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
  }
}
