import 'package:flutter/material.dart';
import 'package:revolution1401/common/resources/resources.dart';
import 'package:revolution1401/modules/gallery/bloc/gallery_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoIndexWidget extends StatefulWidget {
  const VideoIndexWidget({
    super.key,
    required this.bloc,
    required this.index,
  });
  final int index;
  final GalleryBloc bloc;

  @override
  State<VideoIndexWidget> createState() => _VideoIndexWidgetState();
}

class _VideoIndexWidgetState extends State<VideoIndexWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _controller = VideoPlayerController.asset(
      widget.bloc.imageList[widget.index],
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        print(widget.index);
      },
      onTap: () {
        //  Navigator.push(
        //    context,
        //    MaterialPageRoute(
        //      builder: (context) => ImageViewPage(
        //        image: bloc.imageList[index],
        //        controller: PageController(),
        //        items: bloc.imageList,
        //        selectedImage: index,
        //      ),
        //    ),
        //  );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: VideoPlayer(
          _controller,
        ),
      ),
    );
  }
}
