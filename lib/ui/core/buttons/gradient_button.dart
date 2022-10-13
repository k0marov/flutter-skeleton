import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final double width;
  const GradientButton({Key? key, required this.onPressed, required this.text, this.width = 195}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: 70,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.pink, Colors.blue]),
          borderRadius: BorderRadius.circular(40),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                blurRadius: 3) //blur radius of shadow
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              )),
          child: Text(text,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                letterSpacing: 4,
              )),
        ),
      ),
    );
  }
}
