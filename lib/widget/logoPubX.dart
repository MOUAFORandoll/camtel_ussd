import 'package:flutter/material.dart';

class LogoPubX extends StatelessWidget {
  const LogoPubX({ Key? key, required this.width, required this.heigt }) : super(key: key);
  final double width;
   final double heigt;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: heigt,
      decoration: BoxDecoration(
        //color: Colors.white,
        image: DecorationImage(
                    image: AssetImage('assets/images/ussd2.png'), fit: BoxFit.contain)
      ),
    );
  }
}