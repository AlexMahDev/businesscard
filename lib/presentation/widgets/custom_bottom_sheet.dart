import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';


import 'package:share_plus/share_plus.dart';


class CustomBottomSheet extends StatelessWidget {

  final String qrLink;

  const CustomBottomSheet({Key? key, required this.qrLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  splashRadius: 20,
                  icon: Icon(Icons.close, color: Colors.white, size: 35)),
              Center(
                  child: Text('My Card',
                      style: TextStyle(color: Colors.white, fontSize: 25))),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Share.share('You can find my BCard following the link: $qrLink');
                  },
                  splashRadius: 20,
                  icon: Icon(Icons.ios_share, color: Colors.white, size: 30)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              )
            ],
          ),
        ),

        SizedBox(
          height: 80,
        )

      ],
    );
  }
}
