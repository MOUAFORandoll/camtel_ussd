import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ussd_advanced/ussd_advanced.dart';
import 'dart:async';
//import 'package:ussd_service/ussd_service.dart';

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
  String? _response;
   RequestState? _requestState;
  String _requestCode = "";
  String _responseCode = "";
  String? _responseMessage = "";

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

 Future<void> makeMyRequest() async {
    setState(() {
      _requestState = RequestState.ongoing;
    });
    try{
      String? responseMessage;
       responseMessage= await UssdAdvanced.sendAdvancedUssd(code: _requestCode, subscriptionId: -1);
        setState(() {
        _requestState = RequestState.success;
        _responseMessage = responseMessage;
      });           
    } on PlatformException catch(e){

       setState(() {
        _requestState = RequestState.error;
        _responseCode = e is PlatformException ? e.code : "";
        _responseMessage = e.message ?? '';
      });
    }
  // int subscriptionId = 1; // sim card subscription ID
  // //String code = "*#21#"; // ussd code payload
  // try {
  //   String ussdResponseMessage = await UssdService.makeRequest(
  //       -1,
  //       code,
  //       Duration(seconds: 10), // timeout (optional) - default is 10 seconds
  //   );
  //   print("succes! message: $ussdResponseMessage");
  // } catch(e) {
  //   //debugPrint("error! code: ${e.code} - message: ${e.message}");
  //   print(e);
  // }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
          title: const Text('Ussd Plugin demo'),
        ),
        body: Container(
           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // text input
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: TextField(
              //     controller: _controller,
              //     keyboardType: TextInputType.phone,
              //     decoration: const InputDecoration(labelText: 'Ussd code'),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Enter Code',
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          _requestCode = newValue;
                        });
                      },
                    ),
              ),
                const SizedBox(height: 20),
                  MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed:()async{
                    try{
                       await UssdAdvanced.sendUssd(
                  code: _controller.text, subscriptionId: -1);
                    }catch(e){
                      print("++++++++++++++++++++++++++++++++" + e.toString() );
                    }
                  },
                  //  _requestState == RequestState.ongoing
                  //     ? null
                  //     : () {
                  //        makeMyRequest();
                  //       },
                  child: const Text('Send Ussd'),
                ),
          //  if (_requestState == RequestState.ongoing)
          //         Row(
          //           children: const <Widget>[
          //             SizedBox(
          //               width: 24,
          //               height: 24,
          //               child: CircularProgressIndicator(),
          //             ),
          //             SizedBox(width: 24),
          //             Text('Ongoing request...'),
          //           ],
          //         ),
          //       if (_requestState == RequestState.success) ...[
          //         const Text('Last request was successful.'),
          //         const SizedBox(height: 10),
          //         const Text('Response was:'),
          //         Text(
          //           _responseMessage.toString(),
          //           style: const TextStyle(fontWeight: FontWeight.bold),
          //         ),
          //       ],
          //       if (_requestState == RequestState.error) ...[
          //         const Text('Last request was not successful'),
          //         const SizedBox(height: 10),
          //         const Text('Error code was:'),
          //         Text(
          //           _responseCode,
          //           style: const TextStyle(fontWeight: FontWeight.bold),
          //         ),
          //         const SizedBox(height: 10),
          //         const Text('Error message was:'),
          //         Text(
          //           _responseMessage.toString(),
          //           style: const TextStyle(fontWeight: FontWeight.bold),
          //         ),
          //       ]






              // dispaly responce if any
              // if (_response != null)
              //   Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 8),
              //     child: Text(_response!),
              //   ),
        
              // buttons
              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     // ElevatedButton(
              //     //   onPressed: () {
              //     //     UssdAdvanced.sendUssd(
              //     //         code: _controller.text, subscriptionId: -1);
              //     //   },
              //     //   child: const Text('norma\nrequest'),
              //     // ),
              //     // ElevatedButton(
              //     //   onPressed: () async {
              //     //     try{
              //     //        String? _res = await UssdAdvanced.sendAdvancedUssd(
              //     //         code: _controller.text, subscriptionId: -1);
              //     //     setState(() {
              //     //       _response = _res;
              //     //     });
        
              //     //     }catch(e){
              //     //       print(e);
              //     //     }
                     
              //     //   },
              //     //   child: const Text('single session\nrequest'),
              //     // ),
              //     // ElevatedButton(
              //     //   onPressed: () async {
              //     //     String? _res = await UssdAdvanced.multisessionUssd(
              //     //         code: _controller.text, subscriptionId: 1);
              //     //     setState(() {
              //     //       _response = _res;
              //     //     });
              //     //     String? _res2 = await UssdAdvanced.sendMessage('0');
              //     //     setState(() {
              //     //       _response = _res2;
              //     //     });
              //     //     await UssdAdvanced.cancelSession();
              //     //   },
              //     //   child: const Text('multi session\nrequest'),
              //     // ),
              //   ],
              // ),
              //  Padding(
              //    padding: const EdgeInsets.all(10),
              //    child: ElevatedButton(
              //         onPressed: () async {
              //         makeMyRequest(_controller.text);
                       
              //         },
              //         child: const Text('make'),
              //       ),
              //  ),
            ],
          ),
        ),
      );
  }
}