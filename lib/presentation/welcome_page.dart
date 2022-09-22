
import 'package:businesscard/presentation/sign_in_page.dart';
import 'package:businesscard/presentation/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
          backgroundColor: Colors.red.shade400,
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Expanded(
                        child: Image.asset(
                          'assets/images/logo/BCard-logo.png',
                        ),
                      ),
                      Text("Welcome to BCard.",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Let's get your new BCard set up",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute (
                            builder: (BuildContext context) => SignUpPage(),
                          ));
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) => const AuthPage(),
                          //   ),
                          // );
                        },
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text("Create your card",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent,
                                    fontSize: 16)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute (
                              builder: (BuildContext context) => SignInPage(),
                            ));
                          },
                          child: Text("Log in with existing account",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15),
                              textAlign: TextAlign.center)),
                    ],
                  ),
                ),

                //Text("Developed by Aliaksandr Makhrachou", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.center)
              ],
            ),
          ),
        );

  }
}
