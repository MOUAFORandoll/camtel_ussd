import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tussdapp/utils/constants.dart';
import 'package:tussdapp/utils/dimensions.dart';
import 'package:ussd_advanced/ussd_advanced.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_data/sim_data.dart';
import 'widget/buttonacceuil.dart';
import 'package:ussd_service/ussd_service.dart';

class SimpleUssd extends StatefulWidget {
  const SimpleUssd({super.key});

  @override
  State<SimpleUssd> createState() => _SimpleUssdState();
}

enum RequestState {
  ongoing,
  success,
  error,
}

class _SimpleUssdState extends State<SimpleUssd> {
  late TextEditingController _controller;
  String? _response;
  RequestState? _requestState;
  String _requestCode = "";
  String _responseCode = "";
  String? _responseMessage = "";

  bool validate = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
   Future<void> sendUssdRequest() async {
    setState(() {
      _requestState = RequestState.ongoing;
    });
    try {
      String responseMessage;
      await Permission.phone.request();
      if (!await Permission.phone.isGranted) {
        throw Exception("permission missing");
      }

      SimData simData = await SimDataPlugin.getSimData();
      responseMessage = await UssdService.makeRequest(
          simData.cards.first.subscriptionId, _requestCode);
      setState(() {
        _requestState = RequestState.success;
        _responseMessage = responseMessage;
      });
    } on PlatformException catch (e) {
      setState(() {
        _requestState = RequestState.error;
        _responseCode = e is PlatformException ? e.code : "";
        _responseMessage = e.message ?? '';
      });
    }
  }

  Future<void> makeMyRequest() async {
    setState(() {
      _requestState = RequestState.ongoing;
    });
    try {
      String? responseMessage;
      String? _res = await UssdAdvanced.multisessionUssd(
          code: _controller.text, subscriptionId: 0);
      setState(() {
        responseMessage = _res;
      });
      String? _res2 = await UssdAdvanced.sendMessage('0');
      setState(() {
        responseMessage = _res2;
      });
      await UssdAdvanced.cancelSession();
      //responseMessage= await UssdAdvanced.sendAdvancedUssd(code: _requestCode, subscriptionId: -1);
      setState(() {
        _requestState = RequestState.success;
        _responseMessage = responseMessage;
      });
    } on PlatformException catch (e) {
      setState(() {
        _requestState = RequestState.error;
        _responseCode = e is PlatformException ? e.code : "";
        _responseMessage = e.message ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: Dimensions.heightPost,
              height: Dimensions.heightPost,
              decoration: BoxDecoration(
                  //color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage('assets/images/ussd.png'),
                      fit: BoxFit.contain)),
            ),
            Text(
              "Entrez votre code ussd simple",
              style: TextStyle(
                color: kBlackColor,
                fontSize: Dimensions.font15,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: Dimensions.defaultPadding,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Dimensions.height18),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      onChanged: (value) {
                      setState(() {
                        _requestCode = value;
                      });
                       },
                      controller: _controller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          errorText: validate ? "Value Can't Be Empty" : null,
                          border: OutlineInputBorder(),
                          hintText: " exple: #150#"),
                    ),
                  )),
            ),
            ButtonAcceuil(
              description: 'Send',
               ontap:  _requestState == RequestState.ongoing
                      ? null
                      : () async{
                        print(_requestCode);
                          makeMyRequest();
                        },
              //   try {
              //     String? _res = await UssdAdvanced.multisessionUssd(
              //         code: _controller.text, subscriptionId: -1);
              //     setState(() {
              //       _response = _res;
              //     });
              //     String? _res2 = await UssdAdvanced.sendMessage('1');
              //     setState(() {
              //       _response = _res2;
              //     });
              //     await UssdAdvanced.cancelSession();
              //     //await UssdAdvanced.sendUssd(code: _controller.text, subscriptionId: -1);
              //     // setState(() {
              //     //   _response = _res;
              //     // });
              //   } catch (e) {
              //     setState(() {
              //       _response = e.toString();
              //     });
              //   }
            
            ),
            const SizedBox(height: 15),
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: _requestState == RequestState.ongoing
                      ? null
                      : () async{
                         print(_requestCode);
                         await sendUssdRequest();
                        },
                  child: const Text('Send Ussd request'),
                ),
            if (_response != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(_response!),
              ),
                const SizedBox(height: 15),
               if (_requestState == RequestState.ongoing)
                  Row(
                    children: const <Widget>[
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(width: 24),
                      Text('Ongoing request...'),
                    ],
                  ),
                if (_requestState == RequestState.success) ...[
                  const Text('Last request was successful.'),
                  const SizedBox(height: 10),
                  const Text('Response was:'),
                  Text(
                    _responseMessage!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
                if (_requestState == RequestState.error) ...[
                  const Text('Last request was not successful'),
                  const SizedBox(height: 10),
                  const Text('Error code was:'),
                  Text(
                    _responseCode,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text('Error message was:'),
                  Text(
                    _responseMessage!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ]
          ],
        ),
      ),
    ));
  }
}
