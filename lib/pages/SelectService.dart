import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tussdapp/pages/ForfaitBlue.dart';
import 'package:tussdapp/pages/TransfertCredit.dart';
import 'package:ussd_advanced/ussd_advanced.dart';
import 'dart:async';
//import 'package:ussd_service/ussd_service.dart';
import 'package:sim_data/sim_data.dart';
import 'dart:async';
import 'package:ussd_serv/ussd.dart';

import 'package:ussd_service/ussd_service.dart';

import 'package:get/get.dart';
import 'package:tussdapp/utils/colors.dart';
import 'package:tussdapp/utils/dimension.dart';
import 'package:tussdapp/utils/FunctionUser.dart';
import 'package:tussdapp/utils/showToast.dart';
import 'package:tussdapp/widget/app_input.dart';
import 'package:ussd_advanced/ussd_advanced.dart';
import '../widget/app_back_button.dart';
import '../widget/app_button.dart';

class SelectService extends StatefulWidget {
  const SelectService({super.key});

  @override
  State<SelectService> createState() => _SelectServiceState();
}

enum RequestState {
  ongoing,
  success,
  error,
}

class _SelectServiceState extends State<SelectService> {
  TextEditingController codeController = TextEditingController();
  var currentCode = '';
  saveCode() async {
    FunctionUser().savePassword(codeController.text);
    load();
    Get.back();
    toastShowSuccess('Code ${currentCode} enregistre avec succes', Get.context);
  }

  load() async {
    setState(() {
      currentCode = FunctionUser().readPassword();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selectionner un Service'), actions: [
        InkWell(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: kMarginX / 2),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: AppColors.whitecolor,
                ),
                child: Icon(Icons.settings)),
            onTap: () {
              Get.bottomSheet(Container(
                  height: kHeight * .9,
                  padding: EdgeInsets.symmetric(horizontal: kMarginX / 2),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: AppColors.whitecolor,
                  ),
                  child: Column(children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: kMarginY / 2),
                        child: Text(
                          'Code actuel de transaction : ${currentCode}',
                          style: TextStyle(
                              fontSize: kMediumText,
                              fontFamily: 'Montserrat',
                              color: AppColors.grey8,
                              fontWeight: FontWeight.w500),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        top: kMarginY * 2,
                      ),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(bottom: kMarginY / 2),
                              child: Text(
                                'Code',
                                style: TextStyle(
                                    fontSize: kMediumText,
                                    fontFamily: 'Montserrat',
                                    color: AppColors.grey8,
                                    fontWeight: FontWeight.w500),
                              )),
                          AppInput(
                            controller: codeController,
                            onChanged: (value) {},
                            label: '',
                            // validator: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: kMarginY * 2,
                      ),
                      child: AppButton(
                        text: 'Enregistrer',
                        onTap: () async {
                          await saveCode();
                        },
                      ),
                    ),
                  ])));
            })
      ]),
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
              ),

              // buttons

              AppButton(
                text: 'Transfert de credit',
                onTap: () {
                  Get.to(TransfertCredit());
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),

              AppButton(
                text: 'Forfait Blue',
                onTap: () async {
                  Get.to(ForfaitBlue());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
