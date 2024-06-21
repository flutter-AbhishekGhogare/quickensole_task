import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? hintText;
  final String? lableText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final String obscuringCharacter;
  final bool obscureText;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final String? Function(String?)? validator;

  MyTextField({
    super.key,
    this.controller,
    this.hintText,
    this.lableText,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.obscuringCharacter = "*",
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelText: lableText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color.fromRGBO(102, 112, 133, 1),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.none,
      style: style,
      strutStyle: strutStyle,
      textAlign: TextAlign.start,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      validator: validator,
    );
  }
}
