import 'package:flutter/material.dart';
import 'package:pinyinpal/models/player.dart';
import 'package:preload_page_view/preload_page_view.dart';

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

class VideoPage extends StatelessWidget {
  final int pos;
  var myList =
      CircularList<int>([740348490, 416499210, 613729649, 63710700, 63710700]);

  VideoPage(this.pos, {super.key});

  @override
  Widget build(BuildContext context) {
    print(myList[myList._getNormalizedIndex(pos)]);
    return Container(
      child: AspectRatio(
          aspectRatio: 16 / 9, // adjust aspect ratio as per your video
          child: VimeoPlayer(
              videoId: myList[myList._getNormalizedIndex(pos)].toString())),
    );
  }
}

class PreloadPageViewDemo extends StatefulWidget {
  const PreloadPageViewDemo({super.key});

  @override
  _PreloadPageViewState createState() => _PreloadPageViewState();
}

class _PreloadPageViewState extends State<PreloadPageViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PreloadPageView.builder(
          scrollDirection: Axis.vertical,
          preloadPagesCount: 5,
          itemBuilder: (BuildContext context, int position) =>
              VideoPage(position),
          controller: PreloadPageController(initialPage: 1),
          onPageChanged: (int position) {
            print('page changed. current: $position');
          },
        ),
      ),
    );
  }
}
