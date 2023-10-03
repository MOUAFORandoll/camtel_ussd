import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tussdapp/utils/colors.dart';
import 'package:tussdapp/widget/app_button.dart';
import 'package:ussd_advanced/ussd_advanced.dart';
import 'dart:async';
//import 'package:ussd_service/ussd_service.dart';
import 'package:sim_data/sim_data.dart';
import 'dart:async';
import 'package:ussd_serv/ussd.dart';

import 'package:ussd_service/ussd_service.dart';
 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum RequestState {
  ongoing,
  success,
  error,
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _controller;
  var qriosRespnose = '';
  request() async {
    try {
      String? _res = await UssdAdvanced.multisessionUssd(
          code: '*825*1*2*1*1*620414842##', subscriptionId: 0);
      setState(() {
        qriosRespnose = _res!;
      });
      // String? _res2 = await UssdAdvanced.sendMultipleMessages(['0', "1"]);
      // setState(() {
      //   _response = _res2!;
      // });
      print('-----------------^-------------------${qriosRespnose}');
      await UssdAdvanced.cancelSession();
    } catch (e) {
      print(e.toString());
    }
  }

  validate() async {
    try {
      String? _res = await UssdAdvanced.sendMessage('1');
      setState(() {
        qriosRespnose = _res!;
      });
      // String? _res2 = await UssdAdvanced.sendMultipleMessages(['0', "1"]);
      // setState(() {
      //   _response = _res2!;
      // });
      print('-----------------^-------------------${qriosRespnose}');
      await UssdAdvanced.cancelSession();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // makeMyRequest() async {
  //   int subscriptionId = 1; // sim card subscription ID
  //   String code = "*825#"; // ussd code payload
  //   try {
  //     print("staart! message");

  //     var ussdResponseMessage = await UssdService.makeRequest(
  //       subscriptionId,
  //       code,
  //     );
  //     print("succes! message: ${ussdResponseMessage}");
  //   } catch (e) {
  //     debugPrint("error! code: ${e} - message: ");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Que voulez vous faire ?'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // dispaly responce if any

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(qriosRespnose),
              ),

              // buttons
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    text: 'request',
                    onTap: () async {
                      // print(_controller.text);
                      await request();
                    },
                  ),
                  AppButton(
                    text: 'validate',
                    onTap: () async {
                      // print(_controller.text);
                      await validate();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
