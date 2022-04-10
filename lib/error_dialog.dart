import 'package:flutter/material.dart';
import 'package:tournami/primary_button.dart';

class ErrorDialog extends StatefulWidget {
  final String? title;
  final String? detail;
  final String? textButton;
  const ErrorDialog({Key? key, this.detail, this.title, this.textButton})
      : super(key: key);
  @override
  _ErrorDialogState createState() => _ErrorDialogState(
      detail: this.detail, title: this.title, textButton: this.textButton);
}

class _ErrorDialogState extends State<ErrorDialog> {
  final String? title;
  final String? detail;
  final String? textButton;
  _ErrorDialogState({this.title, this.detail, this.textButton});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.

          return Container(
            width: screenWidth * (295 / 375),
            height: screenHeight >= 812
                ? screenHeight * (167 / 812)
                : screenHeight * (200 / 812),
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.clear),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * (20 / 812),
                ),
                Text(
                  this.title ?? '',
                  style: TextStyle(
                    fontFamily: 'Myriad-Bold',
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  this.detail ?? '',
                  style: TextStyle(
                    fontFamily: 'Myriad-Bold',
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: screenHeight * (25 / 812),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: PrimaryButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    height: 50,
                    child: Text(
                      this.textButton ?? "Try again",
                      style: TextStyle(
                          fontFamily: 'Myriad-Bold',
                          color: Colors.white,
                          fontSize: 16),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Colors.orange,
                        Colors.orangeAccent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
