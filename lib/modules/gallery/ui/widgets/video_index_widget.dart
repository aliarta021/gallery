import 'package:flutter/material.dart';
import 'package:revolution1401/common/resources/resources.dart';
import 'package:revolution1401/modules/gallery/bloc/gallery_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.videoPath,
  });
  final String videoPath;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    print(widget.videoPath);
    _controller = VideoPlayerController.asset(
      widget.videoPath,
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();
    _controller.setVolume(0);
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
      onLongPress: () {},
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
