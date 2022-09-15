import 'package:businesscard/presentation/cards_page.dart';
import 'package:businesscard/presentation/welcome_page.dart';
import 'package:businesscard/presentation/widgets/bottom_navigation_bar.dart';
import 'package:businesscard/presentation/widgets/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/card_info_bloc/card_info_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<CardInfoBloc>(
          create: (BuildContext context) => CardInfoBloc()..add(GetCardInfoEvent()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red, ///redAccent
          //primaryColor: Colors.redAccent,
          fontFamily: 'OpenSans',
          appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
            iconTheme: IconThemeData(
                color: Colors.redAccent,
              size: 30
            ),
            foregroundColor: Colors.black, //<-- SEE HERE
            //titleTextStyle: TextStyle()
          ),
        ),
        title: 'Flutter Demo',
        home: WelcomePage(),
        //home: const CustomBottomNavigationBar()
      ),
    );
  }
}



