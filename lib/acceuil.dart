import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tussdapp/multi_ussd.dart';
import 'package:tussdapp/simple_ussd.dart';
import 'package:tussdapp/utils/constants.dart';
import 'package:tussdapp/utils/dimensions.dart';
import 'package:tussdapp/widget/logoPubX.dart';
import 'widget/buttonacceuil.dart';

class AcceuilPage extends StatelessWidget {
  const AcceuilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: kWhiteColor,
        //backgroundColor: context.theme.backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
              LogoPubX(
                        width:  Dimensions.heightPost,  heigt: Dimensions.heightPost,),
                        Text("Generate or Scan your QR Code",
                    style: TextStyle(color: kBlackColor,
                      fontSize: Dimensions.font18, fontWeight: FontWeight.w600,),
                     ),
                     SizedBox(height: Dimensions.defaultPadding,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonAcceuil(
                    description: 'Generate',
                    ontap: (){
                      Get.to(SimpleUssd());
                      }
                    ),
                   ButtonAcceuil(
                    description: 'Scan',
                    ontap: (){Get.to(MultiUssd());}
                    ),
                ],
              ),
             
            ],
          ),
        )
        
        
        );
  }
}