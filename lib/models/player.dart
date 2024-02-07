import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: WebView(
        initialUrl: '',
        allowsInlineMediaPlayback: true,
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          _loadHtml(widget.videoId);
        },
      ),
    );
  }

  void _loadHtml(String videoId) {
    final html = '''
            <html>
              <head>
                <style>
                  body {
                    background-color: black;
                    margin: 0px;
                  }
                </style>
                <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
                <meta http-equiv="Content-Security-Policy" 
                      content="default-src * gap:; script-src * 'unsafe-inline' 'unsafe-eval'; connect-src *; 
                      img-src * data: blob: android-webview-video-poster:; style-src * 'unsafe-inline';">
              </head>
              <body>
                <iframe 
                  src="https://player.vimeo.com/video/$videoId?autoplay=0&loop=0&controls=1&muted=0" 
                  width="100%" 
                  height="100%" 
                  frameborder="0" 
                  allow="autoplay"
                  webkit-playsinline="true"
                  playsinline="true">
                </iframe>
              </body>
            </html>
            ''';
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(html));
    _controller.loadUrl('data:text/html;base64,$contentBase64');
  }
}
