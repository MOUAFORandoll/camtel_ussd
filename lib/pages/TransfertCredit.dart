import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tussdapp/utils/colors.dart';
import 'package:tussdapp/utils/dimension.dart';
import 'package:tussdapp/utils/FunctionUser.dart';
import 'package:tussdapp/utils/showToast.dart';
import 'package:tussdapp/widget/app_back_button.dart';
import 'package:tussdapp/widget/app_button.dart';
import 'package:tussdapp/widget/app_input.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

class TransfertCredit extends StatefulWidget {
  const TransfertCredit({super.key});

  @override
  State<TransfertCredit> createState() => _TransfertCreditState();
}

enum RequestState {
  ongoing,
  success,
  error,
}

class _TransfertCreditState extends State<TransfertCredit> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController montantController = TextEditingController();
  var response = '';
  request() async {
    var password = FunctionUser().readPassword();
    try {
      print(
          '*555*1*${phoneController.text}*${montantController.text}*$password#');
      String? _res = await UssdAdvanced.multisessionUssd(
          code:
              '*555*1*${phoneController.text}*${montantController.text}*$password#',
          subscriptionId: 0);
      setState(() {
        response = _res!;
      });
      toastShowSuccess(response, Get.context);
      print('-----------------^-------------------${response}');
      await UssdAdvanced.cancelSession();
    } catch (e) {
      toastShowError(e, Get.context);

      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfert de Credit'),
        leading: AppBackButton(),
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
                padding: EdgeInsets.only(
                  top: kMarginY * 2,
                ),
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: kMarginY / 2),
                        child: Text(
                          'Numero',
                          style: TextStyle(
                              fontSize: kMediumText,
                              fontFamily: 'Montserrat',
                              color: AppColors.grey8,
                              fontWeight: FontWeight.w500),
                        )),
                    AppInput(
                      controller: phoneController,
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
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: kMarginY / 2),
                        child: Text(
                          'Montant',
                          style: TextStyle(
                              fontSize: kMediumText,
                              fontFamily: 'Montserrat',
                              color: AppColors.grey8,
                              fontWeight: FontWeight.w500),
                        )),
                    AppInput(
                      controller: montantController,
                      onChanged: (value) {},
                      label: '',
                      // validator: (value) {},
                    ),
                  ],
                ),
              ),
              // buttons
              Padding(
                padding: EdgeInsets.only(
                  top: kMarginY * 2,
                ),
                child: AppButton(
                  text: 'Transferer',
                  onTap: () async {
                    await request();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
