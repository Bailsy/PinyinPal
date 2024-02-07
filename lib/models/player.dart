import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VimeoPlayer extends StatefulWidget {
  const VimeoPlayer({
    super.key,
    required this.videoId,
    this.width,
    this.height,
  });

  final String videoId;
  final double? width;
  final double? height;

  @override
  State<VimeoPlayer> createState() => _VimeoPlayerState();
}

class _VimeoPlayerState extends State<VimeoPlayer> {
  void initState() {
    super.initState();

    print(getMp4Link(widget.videoId));
  }

  static Future<String> getMp4Link(String videoId) async {
    final response = await http
        .get(Uri.parse('https://player.vimeo.com/video/${videoId}/config'));
    // Process the response and convert it to List<ExampleSentence>

    // Placeholder: Handle the response and return a List<ExampleSentence>
    if (response.statusCode == 200) {
      var msg = jsonDecode(response.body);
      final String videoURL = msg["request"]["progressive"]["url"];
      return videoURL;
    } else {
      // Handle error case

      return Future.error('Error fetching example sentences');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
