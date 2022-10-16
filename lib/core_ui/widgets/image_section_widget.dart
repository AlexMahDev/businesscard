import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/blocs/image_bloc/image_bloc.dart';
import 'image_pick_source_bottomsheet.dart';


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
      buildWhen: (previous, current) {
          if(current is ImageDeletingState) {
            return false;
          }
          return true;
        },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                                .add(RemoveImageEvent(state.networkImage));
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
