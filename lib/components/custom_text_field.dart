import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.label, required this.hint, this.isSecure= false,required this.color, required this.preIcon, required this.onchanged, required this.controller, required this.type}) : super(key: key);
  final String label;
  final String hint;
  final Color color;
  final IconData preIcon;
  final Function(String)? onchanged;
  final bool isSecure;
  final TextInputType type;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      validator:(value){
        if(value!.isEmpty){
          return "can`t be empty";
        }
      },
      controller: controller,
      obscureText: isSecure,
      onChanged: onchanged,
      keyboardType:type ,
      // controller: emailController,
      decoration: InputDecoration(
          prefixIcon:  Icon(preIcon,color:color,),
          labelText: label,
          labelStyle: TextStyle(color:color),
          hintText: hint,
          hintStyle:  TextStyle(color:color),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1.0,color:color),),
          border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1.0))),
    );
  }
}
