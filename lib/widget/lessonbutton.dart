import 'package:flutter/material.dart';

class BorderPainter extends CustomPainter {
  final Color borderColor;

  const BorderPainter({required this.borderColor, Key? key});
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = sh * 0.15; // desirable value for corners side

    Paint paint = Paint()
      ..color = borderColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..quadraticBezierTo(0, 0, 0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..quadraticBezierTo(0, sh, cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..quadraticBezierTo(sw, 0, sw - cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}

class LessonButton extends StatefulWidget {
  final String text;
  final Color borderColor;
  final Color textColor;
  final bool isAnimated;
  final VoidCallback onPress;

  const LessonButton(
      {required this.text,
      required this.borderColor,
      required this.textColor,
      required this.isAnimated,
      required this.onPress,
      super.key});
  @override
  LessonButtonState createState() => LessonButtonState();
}

class LessonButtonState extends State<LessonButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 10.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double targetRadius = 0;
    Color targetColor = Color.fromARGB(0, 0, 0, 0);

    if (widget.isAnimated == true) {
      targetRadius = _animation.value;
      targetColor = widget.borderColor.withOpacity(0.1);
    }
    return Container(
        padding: const EdgeInsets.only(top: 30, left: 60, right: 60),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: widget.onPress,
          child: CustomPaint(
            foregroundPainter: BorderPainter(borderColor: widget.borderColor),
            child: Container(
              width: 200,
              height: 75,
              decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
                BoxShadow(
                    color: targetColor,
                    blurRadius: targetRadius,
                    spreadRadius: targetRadius)
              ]),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'LibreFranklin',
                      color: widget.textColor),
                ),
              ),
            ),
          ),
        ));
  }
}
