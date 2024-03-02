import 'package:flutter/material.dart';

class AnswerDialog {
  static void successPopup(BuildContext context, String hanzi) {
    showGeneralDialog(
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              iconPadding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              backgroundColor:
                  const Color.fromARGB(255, 48, 201, 86).withOpacity(0.4),
              titleTextStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
              ),
              title: const Text('正确的!', textAlign: TextAlign.center),
              contentTextStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
              ),
              content: Text(hanzi, textAlign: TextAlign.center),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        throw ArgumentError('the value is Null!');
      },
    );

    // Dismiss the dialog after 5 seconds
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  static void welcomePopup(BuildContext context) {
    showGeneralDialog(
      barrierColor: const Color.fromARGB(255, 11, 86, 184).withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              iconPadding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              backgroundColor:
                  const Color.fromARGB(255, 11, 86, 184).withOpacity(0.4),
              titleTextStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
              ),
              title: const Text('欢饮您!', textAlign: TextAlign.center),
              contentTextStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        throw ArgumentError('the value is Null!');
      },
    );

    // Dismiss the dialog after 5 seconds
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  static void failurePopup(BuildContext context, String hanzi) {
    showGeneralDialog(
      barrierColor: const Color.fromARGB(255, 184, 11, 11).withOpacity(0),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              iconPadding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              backgroundColor:
                  const Color.fromARGB(255, 201, 48, 48).withOpacity(1),
              titleTextStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
              ),
              title: const Text('不正确!', textAlign: TextAlign.center),
              contentTextStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
              ),
              content: Text(hanzi, textAlign: TextAlign.center),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 100),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        throw ArgumentError('the value is Null!');
      },
    );

    // Dismiss the dialog after 5 seconds
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}
