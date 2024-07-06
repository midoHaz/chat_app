import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.label, required this.width, required this.height, required this.color, required this.ontap}) : super(key: key);
  final String label;
  final double width;
  final double height;
  final Color color;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
           label,
            style:const TextStyle(
                color:kPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
