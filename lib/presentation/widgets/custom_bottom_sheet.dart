import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/share_card_bloc.dart';

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
                      child: Image.asset('lib/assets/images/qr_code.png')),
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

class ChangeCardMethodBar extends StatelessWidget {
  final String shareMethodName;

  const ChangeCardMethodBar({Key? key, required this.shareMethodName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(23)),
          border: Border.all(color: Colors.white, width: 3)),
      height: 80,
      child: Row(
        children: [
          Expanded(
              child: Period(
            shareMethodName: 'Scan',
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            isSelected: shareMethodName == 'Scan',
                icon: Icons.qr_code_2,
          )),
          Container(
            width: 3,
            color: Colors.white,
          ),
          Expanded(
              child: Period(
            shareMethodName: 'Text',
            borderRadius: BorderRadius.all(Radius.zero),
            isSelected: shareMethodName == 'Text',
                icon: Icons.message,
          )),
          Container(
            width: 3,
            color: Colors.white,
          ),
          Expanded(
              child: Period(
            shareMethodName: 'Email',
            borderRadius: BorderRadius.all(Radius.zero),
            isSelected: shareMethodName == 'Email',
                icon: Icons.email,
          )),
          Container(
            width: 3,
            color: Colors.white,
          ),
          Expanded(
              child: Period(
            shareMethodName: 'Copy',
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            isSelected: shareMethodName == 'Copy',
                icon: Icons.copy,
          )),
          // Expanded(
          //     child: Period(
          //         index: 3,
          //         borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          //         isSelected: selectedIndex == 3
          //     )
          // ),
        ],
      ),
    );
  }
}

class Period extends StatelessWidget {

  final String shareMethodName;
  final BorderRadius borderRadius;
  final bool isSelected;
  final  IconData icon;

  const Period(
      {Key? key,
      required this.shareMethodName,
      required this.borderRadius,
      required this.isSelected,
        required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shareCardBloc = BlocProvider.of<ShareCardBloc>(context);
    return ChoiceChip(
      padding: const EdgeInsets.all(0),
      label: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: 40, color: isSelected ? Colors.redAccent : Colors.white),
          SizedBox(
            height: 5,
          ),
          Center(child: Text(shareMethodName)),
        ],
      ), //ВОЗМОЖНО, ЛУЧШЕ УБРАТЬ SIZEDBOX
      selected: isSelected,
      selectedColor: Colors.white,
      onSelected: (bool selected) {
        shareCardBloc.add(ChangeShareCardMethodEvent(shareMethodName));
      },
      backgroundColor: Colors.redAccent,
      labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.redAccent : Colors.white),
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
    );
  }
}
