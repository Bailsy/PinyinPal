import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo() async {
    final videoURL = await getMp4Link(widget.videoId);
    _controller = VideoPlayerController.network(videoURL)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          // Start playing the video automatically when initialized
          _controller.play();
        });
      });
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
  Widget build(BuildContext context) {
    return _isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Center(child: CircularProgressIndicator());
  }
}
