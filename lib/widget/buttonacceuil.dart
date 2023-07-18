import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ButtonAcceuil extends StatefulWidget {
  const ButtonAcceuil({Key? key, required this.description, this.ontap}) : super(key: key);
 final String description;
 final ontap;

  @override
  State<ButtonAcceuil> createState() => _ButtonAcceuilState();
}

class _ButtonAcceuilState extends State<ButtonAcceuil> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
        child:Container(
          width: MediaQuery.of(context).size.width*0.3,
          alignment: Alignment.center,
           decoration: BoxDecoration(
            color: kBlueColor,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          padding: EdgeInsets.all(8),
          child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.description, style: TextStyle(
                color: kWhiteColor, 
                fontWeight: FontWeight.w700,
                fontSize:  18,), )
             
            ],
          ),
        )
  );
  }
}
