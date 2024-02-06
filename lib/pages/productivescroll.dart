import 'package:flutter/material.dart';
import 'package:pinyinpal/models/player.dart';
import 'package:preload_page_view/preload_page_view.dart';

class VideoPage extends StatelessWidget {
  final String videoId;

  VideoPage(this.videoId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: 16 / 9, // adjust aspect ratio as per your video
        child: VimeoPlayer(videoId: videoId),
      ),
    );
  }
}

class PreloadPageViewDemo extends StatefulWidget {
  PreloadPageViewDemo({Key? key}) : super(key: key);

  @override
  _PreloadPageViewState createState() => _PreloadPageViewState();
}

class _PreloadPageViewState extends State<PreloadPageViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PreloadPageView Demo"),
      ),
      body: Container(
        child: PreloadPageView.builder(
          scrollDirection: Axis.vertical,
          preloadPagesCount: 5,
          itemBuilder: (BuildContext context, int position) =>
              VideoPage("351593873"),
          controller: PreloadPageController(initialPage: 1),
          onPageChanged: (int position) {
            print('page changed. current: $position');
          },
        ),
      ),
    );
  }
}
