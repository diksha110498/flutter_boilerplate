import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_boilerplate/src/core/app_theme/app_colors.dart';
import 'package:flutter_boilerplate/src/core/app_utils/app_utils.dart';
import 'package:video_player/video_player.dart';

class VideoViewScreen extends StatefulWidget {
  final String videoUrls;
  final String activityName;

  const VideoViewScreen(
      {super.key, required this.videoUrls, required this.activityName});

  @override
  State<VideoViewScreen> createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  Future initializeVideo() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrls));
    await _videoPlayerController!.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return const Center(
          child: Icon(Icons.error),
        );
      },
    );
    setState(() { });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: false,
        titleSpacing: 0.0,
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white, // <= You can change your color here.
        ),
        title: Text(
          widget.activityName,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: _chewieController == null ? AppUtils.showSpinner(color: Colors.white) : Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(controller: _chewieController!),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    _chewieController!.dispose();
    super.dispose();
  }
}
