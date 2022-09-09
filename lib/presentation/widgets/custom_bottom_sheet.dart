import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/share_card_bloc/share_card_bloc.dart';
import 'change_card_method_bar.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShareCardBloc>(
      create: (context) => ShareCardBloc(),
      child: BlocBuilder<ShareCardBloc, ShareCardState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          splashRadius: 20,
                          icon: Icon(Icons.close, color: Colors.white, size: 30)),
                      Center(
                          child: Text('My Card',
                              style: TextStyle(color: Colors.white, fontSize: 18))),
                      SizedBox(width: 35)
                    ],
                  ),
                  Container(
                      height: 250,
                      margin: EdgeInsets.all(40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white),
                      child: Image.asset('assets/images/qr_code.png')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                        'Point your camera at the QR code to receive the card!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),



              if (state is ShareCardByScanState)
                ChangeCardMethodBar(shareMethodName: 'Scan'),
              if (state is ShareCardByTextState)
                ChangeCardMethodBar(shareMethodName: 'Text'),
              if (state is ShareCardByEmailState)
                ChangeCardMethodBar(shareMethodName: 'Email'),
              if (state is ShareCardByCopyState)
                ChangeCardMethodBar(shareMethodName: 'Copy')
            ],
          );
        },
      ),
    );
  }
}
