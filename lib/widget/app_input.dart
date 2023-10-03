import 'package:flutter/material.dart';
 
import 'package:flutter/cupertino.dart'; 
import 'package:tussdapp/utils/colors.dart';

import '../utils/dimension.dart';

class AppInput extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String label;
  final String? errorText;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputType? textInputType;
  final Icon? icon;
  final int? maxLength;
  const AppInput(
      {Key? key,
      required this.controller,
      required this.label,
      this.validator,
      this.placeholder,
      this.errorText,
      this.onChanged,
      this.obscureText = false,
      this.textInputType,
      this.maxLength,
      this.icon})
      : super(key: key);

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: widget.controller,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.grey8,
        fontSize: kMediumText,
        fontFamily: 'Montserrat',
      ),
      // maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryGreen, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey7, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.grey7, width: 1.5),
          ),
          errorText: widget.errorText,
          errorStyle: TextStyle(
            fontSize: 8,
            fontFamily: 'Montserrat',
          ),
          labelText: widget.label,
          labelStyle: TextStyle(
            color: AppColors.grey7, fontFamily: 'Montserrat',
            // fontWeight: FontWeight.w500,
            fontSize: kMdText,
          ),
          hintText: widget.placeholder,
          suffixIcon: widget.icon),
      validator: widget.validator,
      obscureText: isVisible,
      keyboardType: widget.textInputType,
    );
  }
}

class AppInputPassword extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String label;
  final String? errorText;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  // final bool valid;
  final TextInputType? textInputType;
  const AppInputPassword({
    Key? key,
    required this.controller,
    required this.label,
    this.validator,
    // this.valid = false,
    this.placeholder,
    this.errorText,
    this.onChanged,
    this.obscureText = false,
    this.textInputType,
  }) : super(key: key);

  @override
  State<AppInputPassword> createState() => _AppInputPasswordState();
}

class _AppInputPasswordState extends State<AppInputPassword> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: widget.controller,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.grey8,
        fontFamily: 'Montserrat',
        fontSize: kMediumText,
      ),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryGreen, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            //  borderSide : BorderSide(color:Colors.blue,width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          errorText: widget.errorText,
          errorStyle: TextStyle(
            fontSize: 8,
            fontFamily: 'Montserrat',
          ),
          labelText: widget.label,
          labelStyle: TextStyle(
            color: AppColors.grey7, fontFamily: 'Montserrat',
            // fontWeight: FontWeight.w500,
            fontSize: kMdText,
          ),
          hintText: widget.placeholder,
          suffixIcon: widget.obscureText == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(
                    isVisible ? Icons.remove_red_eye : CupertinoIcons.eye_slash,
                    /*     */
                  ),
                )
              : null),
      validator: widget.validator,
      obscureText: isVisible,
      keyboardType: widget.textInputType,
    );
  }
}
