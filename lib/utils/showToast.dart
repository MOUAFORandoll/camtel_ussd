import 'package:flutter/material.dart'
    show
        Container,
        EdgeInsets,
        Expanded,
        Icon,
        InkWell,
        Icons,
        MainAxisAlignment,
        Row,
        ScaffoldMessenger,
        Colors,
        SnackBar,
        Text;
import 'package:flutter/src/widgets/basic.dart';
import 'package:get/get.dart';
import 'package:tussdapp/utils/colors.dart';

toastShowSuccess(message, context) {
  // Toast.show(
  //   message,
  //   context,
  //   duration: 6,
  //   gravity: Toast.BOTTOM,
  //   backgroundColor: color,
  // );
  var snackBar = SnackBar(
      content: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Icon(Icons.close, color: Colors.white),
                    onTap: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      message,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.check_circle_sharp)
                ],
              ),
            ],
          )),
      backgroundColor: AppColors.primaryGreen);
  // Step 3
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

toastShowError(message, context) {
  // Toast.show(
  //   message,
  //   context,
  //   duration: 6,
  //   gravity: Toast.BOTTOM,
  //   backgroundColor: color,
  // );
  var snackBar = SnackBar(
      content: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Icon(Icons.close, color: Colors.white),
                    onTap: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Text(
                    message,
                    // overflow: TextOverflow.ellipsis,
                  )),
                  Icon(Icons.warning)
                ],
              ),
            ],
          )),
      backgroundColor: AppColors.red);
  // Step 3
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
