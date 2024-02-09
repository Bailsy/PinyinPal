import 'dart:async';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/models/player.dart';
import 'package:pinyinpal/pages/profile.dart';
import 'package:preload_page_view/preload_page_view.dart';

class GlobalCode {
  static int _code = 0;
  static StreamController<int> _codeController =
      StreamController<int>.broadcast();

  static int get code => _code;

  static set code(int newValue) {
    if (_code != newValue) {
      _code = newValue;
      _codeController.add(_code); // Notify subscribers about the change
    }
  }

  static Stream<int> get codeStream => _codeController.stream;
}

class CircularList<T> {
  List<T> _items;
  final int _currentIndex = 0;

  CircularList(this._items) {
    _items = _items;
  }

  int get length => _items.length;

  T operator [](int index) {
    return _items[_getNormalizedIndex(index)];
  }

  void operator []=(int index, T value) {
    _items[_getNormalizedIndex(index)] = value;
  }

  _getNormalizedIndex(int index) {
    if (length == 0) {
      throw StateError("List is empty");
    }
    // Normalize the index to be within the bounds of the list
    return (index % length + length) % length;
  }
}

class VideoPage extends StatefulWidget {
  final int pos;
  // Added key parameter for super constructor

  VideoPage(this.pos, {super.key}); // Passing key to super constructor

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  var myList = CircularList<int>([740348490, 416499210, 613729649, 63710700]);
  @override
  Widget build(BuildContext context) {
    print(myList[myList._getNormalizedIndex(widget.pos)]);
    return Container(
      child: AspectRatio(
          aspectRatio: 16 / 9, // adjust aspect ratio as per your video
          child: VimeoPlayer(
              videoId:
                  myList[myList._getNormalizedIndex(widget.pos)].toString())),
    );
  }
}

class PreloadPageViewDemo extends StatefulWidget {
  const PreloadPageViewDemo({super.key});

  @override
  _PreloadPageViewState createState() => _PreloadPageViewState();
}

class _PreloadPageViewState extends State<PreloadPageViewDemo> {
  var myList = CircularList<int>([740348490, 416499210, 613729649, 63710700]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(LineAwesomeIcons.user),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          },
        ),
      ),
      body: Container(
        child: PreloadPageView.builder(
          scrollDirection: Axis.vertical,
          preloadPagesCount: 2,
          itemBuilder: (BuildContext context, int position) =>
              VideoPage(position),
          controller: PreloadPageController(initialPage: 1),
          onPageChanged: (int position) {
            GlobalCode.code = myList[myList._getNormalizedIndex(position)];
          },
        ),
      ),
    );
  }
}
