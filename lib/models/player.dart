import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VimeoPlayer extends StatefulWidget {
  const VimeoPlayer({
    Key? key,
    required this.videoId,
  }) : super(key: key);

  final String videoId;

  @override
  State<VimeoPlayer> createState() => _VimeoPlayerState();
}

class _VimeoPlayerState extends State<VimeoPlayer> {
  late String vimeoPlayerUrl;

  @override
  void initState() {
    super.initState();
    // Build the Vimeo video player URL with the provided videoId
    vimeoPlayerUrl =
        'https://player.vimeo.com/video/${widget.videoId}?autoplay=1&controls=0&muted=1';
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialData: InAppWebViewInitialData(data: '''<html>
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
src="$vimeoPlayerUrl" 
width="100%" 
height="100%" 
frameborder="0" 
allow="fullscreen" 
allowfullscreen
webkit-playsinline="true"> <!-- Add webkit-playsinline attribute -->
</iframe>

   </body>
  </html>'''),
    );
  }
}
