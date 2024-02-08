import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
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
      _controller.dispose(); // Dispose the previous controller
      _controller = VideoPlayerController.network(videoUrl);
      _initializeVideoPlayerFuture = _controller.initialize();
      await _initializeVideoPlayerFuture;
      _controller.setLooping(true);

      GlobalCode.codeStream.listen((newCode) {
        print(newCode);
        if (newCode.toString() == widget.videoId) {
          playVideo();
        } else {
          pauseVideo();
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
      _controller.play();
    });
  }

  void pauseVideo() {
    setState(() {
      _controller.pause();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: Stack(
                children: <Widget>[
                  InkWell(
                    child: VideoPlayer(_controller),
                    onTap: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                  ),
                  Positioned(
                    bottom: 10, // Set the distance from the bottom
                    left: 10,
                    right: 10,
                    child: GlassContainer(
                      width: 200,
                      height: 100,
                      borderRadius: 20,
                      blur: 10,
                      opacity: 0.3,
                      child: Center(
                        child: Row(children: <Widget>[
                          Container(
                            width: 10,
                          ),
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                  "http://pinyinpal.com/logo.png"),
                            ),
                          ),
                          Text("Teaching Chinese fast",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255)))
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class GlassContainer extends StatelessWidget {
  final double width;
  final double height;
  final double blur;
  final double opacity;
  final double borderRadius;
  final Widget child;

  const GlassContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.blur,
    required this.opacity,
    required this.borderRadius,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}
