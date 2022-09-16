import 'package:businesscard/presentation/cards_page.dart';
import 'package:businesscard/presentation/welcome_page.dart';
import 'package:businesscard/presentation/widgets/bottom_navigation_bar.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/card_info_bloc/card_info_bloc.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/card_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final card = FirebaseFirestore.instance.collection('cards').doc('tvaV6VppRNfHVdEwQCSu');
  // final snapshot = await card.get();
  // print(snapshot.data());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => CardRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(
                  authRepository: RepositoryProvider.of<AuthRepository>(
                      context),
                ),
          ),
          BlocProvider<CardInfoBloc>(
            create: (context) => CardInfoBloc(cardRepository: RepositoryProvider.of<CardRepository>(context)),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.red,

            ///redAccent
            //primaryColor: Colors.redAccent,
            fontFamily: 'OpenSans',
            appBarTheme: AppBarTheme(
              centerTitle: true,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Colors.redAccent, size: 30),
              foregroundColor: Colors.black, //<-- SEE HERE
              //titleTextStyle: TextStyle()
            ),
          ),
          title: 'Flutter Demo',
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                if (snapshot.hasData) {
                  return BlocProvider<CardInfoBloc>.value(
                    value: BlocProvider.of<CardInfoBloc>(context)
                      ..add(GetCardInfoEvent()),
                    child: CustomBottomNavigationBar(),
                  );
                }
                // Otherwise, they're not signed in. Show the sign in page.
                return WelcomePage();
              }),
          //home: const CustomBottomNavigationBar()
        ),
      ),
    );
  }
}
