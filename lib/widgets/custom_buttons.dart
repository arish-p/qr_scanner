import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({Key? key, required this.onTap,
    required this.color, required this.text,
    this.textColor = Colors.white, this.height = 60, this.fontSize = 20, this.onShadow = true}) : super(key: key);

  final Function() onTap;
  final Color color;
  final Color textColor;
  final String text;
  final double height;
  final double fontSize;
  final bool onShadow;
  final style = const TextStyle(
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: (onShadow) ? 5 : 0,
      shadowColor: (onShadow) ? Colors.grey.shade200 : null,
      color: color,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        splashColor: Colors.grey,
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: height,
          decoration:  const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Center(child: Text(text, style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color:  textColor,
          ))),
        ),
      ),
    );
  }
}
