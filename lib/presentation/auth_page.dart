import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

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
            Text("Welcome back, let's sign in", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),

          ],
        ),
      ),
    );
  }
}



class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

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
    return Container();
  }
}

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {

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
    return Container();
  }
}

