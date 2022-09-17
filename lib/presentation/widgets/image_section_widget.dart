
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/image_bloc/image_bloc.dart';
import '../create_card_page.dart';

class ImageSectionWidget extends StatelessWidget {

  final ImageBloc imageBloc;
  final String addTitle;
  final String editTitle;
  final String removeTitle;

  const ImageSectionWidget({Key? key, required this.imageBloc, required this.addTitle, required this.editTitle, required this.removeTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageState>(
      bloc: imageBloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // if (state is ImagePickLoadedState)
              //   Expanded(
              //       child: Image.file(state.image, height: 150)),
              if (state is ImageNetworkLoadedState)
                Expanded(
                    child: Image.network(state.networkImage, height: 150, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {return Container();})),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return BlocProvider.value(
                              value: imageBloc,
                              child: ImagePickSourceBottomSheet(),
                            );
                          },
                        );
                      },
                      child: Text(
                        state is ImageNetworkLoadedState
                            ? editTitle
                            : addTitle,
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (state is ImageNetworkLoadedState)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            imageBloc
                                .add(RemoveImageEvent());
                          },
                          child: Text(
                            removeTitle,
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ImagePickSourceBottomSheet extends StatelessWidget {
  //final ImageBloc imageBloc;

  const ImagePickSourceBottomSheet({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final imageBloc = BlocProvider.of<ImageBloc>(context);

    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final imageBloc = BlocProvider.of<ImageBloc>(context);
                        imageBloc.add(UploadImageEvent(true));
                        Navigator.pop(context);
                      },
                      child: Center(
                          child: Text('Select from photo library',
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 18))),
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final imageBloc = BlocProvider.of<ImageBloc>(context);
                        imageBloc.add(UploadImageEvent(false));
                        Navigator.pop(context);
                      },
                      child: Center(
                          child: Text('Take photo',
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 18))),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                    child: Text('Cancel',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))),
              ),
            ),
          ],
        ),
      ),
      // child: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     mainAxisSize: MainAxisSize.min,
      //     children: <Widget>[
      //       const Text('Modal BottomSheet'),
      //       ElevatedButton(
      //         child: const Text('Close BottomSheet'),
      //         onPressed: () => Navigator.pop(context),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}