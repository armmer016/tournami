import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final Widget? child;
  final double? width;
  double height = 40;
  final Function? onPressed;
  final Color? borderColor;
  final Color? bgColor;

  SecondaryButton({
    Key? key,
    @required this.child,
    this.width = double.infinity,
    this.height = 40,
    this.onPressed,
    this.borderColor,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor ?? Colors.black, width: 1),
          color: bgColor),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            splashColor: Colors.white.withOpacity(0),
            highlightColor: Colors.white.withOpacity(0),
            onTap: onPressed ?? dummy(),
            child: Center(
              child: child,
            )),
      ),
    );
  }

  dummy() {
    return 0;
  }
}
