import 'package:businesscard/core_ui/themes/text_theme.dart';
import 'package:businesscard/presentation/pages/sign_in_page.dart';
import 'package:businesscard/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.red.shade400,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/logo/BCard-logo.png',
                    ),
                  ),
                  Text(localText!.welcomeToBCard,
                      style: TextThemeCustom.welcomeToBCardTextTheme,
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(localText.setUpNewCard,
                      style: TextThemeCustom.setUpNewCardTextTheme,
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const SignUpPage(),
                      ));
                    },
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(localText.createCardButton,
                            style:
                                TextThemeCustom.createCardRedButtonTextTheme),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => const SignInPage(),
                        ));
                      },
                      child: Text(localText.logInButton,
                          style: TextThemeCustom.logInButtonTextTheme,
                          textAlign: TextAlign.center)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
