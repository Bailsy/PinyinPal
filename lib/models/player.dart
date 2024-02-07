import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pinyinpal/pages/productivescroll.dart';
import 'package:video_player/video_player.dart';

class VimeoPlayer extends StatefulWidget {
  const VimeoPlayer({
    Key? key,
    required this.videoId,
    this.width,
    this.height,
  }) : super(key: key);

  final String videoId;
  final double? width;
  final double? height;

  @override
  State<VimeoPlayer> createState() => _VimeoPlayerState();
}

class _VimeoPlayerState extends State<VimeoPlayer> {
  late VideoPlayerController _controller = VideoPlayerController.network('');
  late Future<void> _initializeVideoPlayerFuture = Future.value();

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() async {
    try {
      final videoUrl = await getMp4Link(widget.videoId);
      _controller = VideoPlayerController.network(videoUrl);
      _initializeVideoPlayerFuture = _controller.initialize();
      await _initializeVideoPlayerFuture;
      _controller.setLooping(true);

      GlobalCode.codeStream.listen((newCode) {
        print(newCode);
        if (newCode.toString() == widget.videoId) {
          playVideo();
        }
      });
      // Rebuild the widget after getting video URL
    } catch (e) {
      print('Failed to initialize video player: $e');
    }
  }

  static Future<String> getMp4Link(String videoId) async {
    final response = await http
        .get(Uri.parse('https://player.vimeo.com/video/${videoId}/config'));
    if (response.statusCode == 200) {
      var msg = json.decode(response.body);
      final String videoURL = msg["request"]["files"]["progressive"][0]["url"];
      return videoURL;
    } else {
      throw Exception('Failed to load video URL');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void playVideo() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InkWell(
      onTap: () {
        playVideo();
      },
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: VideoPlayer(_controller),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    ));
  }
}
