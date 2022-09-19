import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../blocs/share_card_bloc/share_card_bloc.dart';
import 'change_card_method_bar.dart';

import 'package:share_plus/share_plus.dart';


class CustomBottomSheet extends StatelessWidget {

  final String qrLink;

  const CustomBottomSheet({Key? key, required this.qrLink}) : super(key: key);

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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            splashRadius: 20,
                            icon: Icon(Icons.close, color: Colors.white, size: 40)),
                        Center(
                            child: Text('My Card',
                                style: TextStyle(color: Colors.white, fontSize: 25))),
                        SizedBox(width: 40)
                      ],
                    ),
                  ),
                  Container(
                      height: 250,
                      margin: EdgeInsets.all(40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white),
                      child: QrImage(
                        data: qrLink,
                        version: QrVersions.auto,
                        //size: 250,
                        gapless: false,
                        errorStateBuilder: (cxt, err) {
                          return Container();
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                        'Point your camera at the QR code to receive the card!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  Share.share('You can find my BCard following the link: $qrLink');
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Icon(Icons.ios_share_rounded, color: Colors.white, size: 30),
                      Expanded(
                        child: Center(
                          child: Text("Share",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 25)),
                        ),
                      ),
                      SizedBox(
                        width: 30
                      )
                    ],
                  ),
                ),
              ),


              //===================================================
              //OLD UI OF THE ORIGINAL APP
              //===================================================
              // if (state is ShareCardByScanState)
              //   ChangeCardMethodBar(shareMethodName: 'Scan'),
              // if (state is ShareCardByTextState)
              //   ChangeCardMethodBar(shareMethodName: 'Text'),
              // if (state is ShareCardByEmailState)
              //   ChangeCardMethodBar(shareMethodName: 'Email'),
              // if (state is ShareCardByCopyState)
              //   ChangeCardMethodBar(shareMethodName: 'Copy')
            ],
          );
        },
      ),
    );
  }
}
