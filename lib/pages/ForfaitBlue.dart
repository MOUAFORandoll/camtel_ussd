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

class ForfaitBlue extends StatefulWidget {
  const ForfaitBlue({super.key});

  @override
  State<ForfaitBlue> createState() => _ForfaitBlueState();
}

enum RequestState {
  ongoing,
  success,
  error,
}

class _ForfaitBlueState extends State<ForfaitBlue> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController montantController = TextEditingController();
  var response = '';
  request() async {
    var password = FunctionUser().readPassword();
    try {
      print(
        '${_currentForfaitCode + phoneController.text + '*' + password}#',
      );
      String? _res = await UssdAdvanced.multisessionUssd(
          code:
              '${_currentForfaitCode + phoneController.text + '*' + password}#',
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

  List<Forfait> forfaitBlue = [
    Forfait(code: '*865*1*2*1*1*', titre: 'Blue 2000'),
    Forfait(code: '*865*1*2*1*2*', titre: 'Blue 3000'),
    Forfait(code: '*865*1*2*1*3*', titre: 'Blue 5000'),
    Forfait(code: '*865*1*2*1*4*', titre: 'Blue 10000'),
    Forfait(code: '*865*1*2*1*5*', titre: 'Blue 20000'),
    // Forfait(code: '*865*1*4#', titre: 'Blue One')
  ];
  var _currentForfaitCode = '00';
  seclectForfait(forfait) {
    setState(() {
      _currentForfaitCode = forfait.code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisissez un forfait blue'),
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
              ListView.builder(
                itemCount: forfaitBlue.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => InkWell(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                              shape: CircleBorder(),
                              value: forfaitBlue[index].code ==
                                  _currentForfaitCode,
                              onChanged: (val) {
                                seclectForfait(
                                  val,
                                );
                              }),
                          Container(child: Text(forfaitBlue[index].titre)),
                        ],
                      ),
                    ),
                    onTap: () {
                      print(forfaitBlue[index].code);
                      seclectForfait(
                        forfaitBlue[index],
                      );
                    }),
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
              // Padding(
              //   padding: EdgeInsets.only(
              //     top: kMarginY * 2,
              //   ),
              //   child: Column(
              //     children: [
              //       Container(
              //           alignment: Alignment.centerLeft,
              //           margin: EdgeInsets.only(bottom: kMarginY / 2),
              //           child: Text(
              //             'Montant',
              //             style: TextStyle(
              //                 fontSize: kMediumText,
              //                 fontFamily: 'Montserrat',
              //                 color: AppColors.grey8,
              //                 fontWeight: FontWeight.w500),
              //           )),
              //       AppInput(
              //         controller: montantController,
              //         onChanged: (value) {},
              //         label: '',
              //         // validator: (value) {},
              //       ),
              //     ],
              //   ),
              // ),
              // buttons
              Padding(
                padding: EdgeInsets.only(
                  top: kMarginY * 2,
                ),
                child: AppButton(
                  text: 'Valider',
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

class Forfait {
  Forfait({
    required this.titre,
    required this.code,
  });

  String titre;
  String code;
}
