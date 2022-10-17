import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/blocs/image_bloc/image_bloc.dart';

class ImagePickSourceBottomSheet extends StatelessWidget {
  const ImagePickSourceBottomSheet({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    );
  }
}