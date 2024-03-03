import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pinyinpal/constants/colour.dart';

class CharacterAnimator extends StatefulWidget {
  final String character;
  final Color confidence;
  const CharacterAnimator({
    Key? key,
    required this.confidence,
    required this.character,
  }) : super(key: key);

  @override
  State<CharacterAnimator> createState() => _CharacterAnimatorState();
}

class _CharacterAnimatorState extends State<CharacterAnimator> {
  late String characterAnimatorUrl;
  bool webViewError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose of the webview controller when the widget is disposed of
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: pGreyColour,
      height: 300,
      width: 500,
      child: webViewError
          ? Center(
              child: Text('WebView Initialization Failed'),
            )
          : InAppWebView(
              initialSettings: InAppWebViewSettings(
                  underPageBackgroundColor: pGreyColour,
                  transparentBackground: true),
              initialData: InAppWebViewInitialData(data: '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
      
    <style>
        body {
            background-color: transparent;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            height: 100vh;
            margin: 0;
            padding-top: 20px; /* Adjust top padding as needed */
        }
        .character-target-div {
            /* Add any additional styling for the character container here */
            margin-top: 20px; /* Adjust margin as needed */
        }

    </style>
    <script src="https://cdn.jsdelivr.net/npm/hanzi-writer@3.5/dist/hanzi-writer.min.js"></script>
</head>
<body>
  <div id="character-target"></div>
    <script>
        var characters = "${widget.character}"; // String of characters to animate
        var charTargets = [];

        characters.split('').forEach(function(char, index) {
            var targetId = 'character-target-' + (index + 1);
            var div = document.createElement('div');
            div.id = targetId;
            div.className = 'character-target-div';
            document.getElementById('character-target').appendChild(div);
            var charTarget = HanziWriter.create(targetId, char, {
               strokeColor: '#${widget.confidence.value.toRadixString(16).substring(2).toUpperCase()}',
                width: 100,
                height: 100,
                padding: 5,
                showCharacter: false
            });
            charTargets.push(charTarget);
        });

        function animateCharacter(charIndex) {
            return new Promise(resolve => {
                setTimeout(() => {
                    charTargets[charIndex].hideCharacter();
                    charTargets[charIndex].animateCharacter({
                        onComplete: resolve
                    });
                }, 1000); // Delay before animating next character
            });
        }

        async function chainAnimations() {
            for (let i = 0; i < charTargets.length; i++) {
                await animateCharacter(i);
            }
            return false;
        }

        async function startAnimation() {
            animate = ${true};
            if (animate == true) {
                animate = await chainAnimations();
            }
            setTimeout(startAnimation, 1000); // Check every second
        }

        startAnimation();
    </script>
</body>
</html>'''),
              onLoadError: (controller, url, code, message) {
                setState(() {
                  webViewError = true;
                });
              },
            ),
    );
  }
}
