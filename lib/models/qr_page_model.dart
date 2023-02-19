import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_generator/const.dart';
import 'package:qr_generator/dialogs/dialogs.dart';

import 'client_model.dart';

class QrPageModel with ChangeNotifier{

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRView? qrView;
  QRViewController? qrViewController;
  ClientModel? result;
  bool isError = false;

  var scanArea = (MediaQuery.of(navigatorKey.currentContext!).size.width < 400 ||
      MediaQuery.of(navigatorKey.currentContext!).size.height < 400)
      ? 150.0
      : 300.0;


  QrPageModel(){
    qrView = createNewQRView();
  }

  void onQRViewCreated(QRViewController controller) {

    qrViewController = controller;
    qrViewController!.resumeCamera();
    notifyListeners();
    controller.scannedDataStream.listen((scanData) {
      try{
        result = ClientModel.fromJson(jsonDecode(scanData.code!));
      }catch(exception){
        if(isError == false){
          isError = true;
          showErrorDialog(textError: "Не удалось считать QR код").then((value) {
            isError = false;
          });
        }
        result = null;
      }

        notifyListeners();
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }


  void reset(){
    result = null;
    notifyListeners();
    if (Platform.isAndroid) {
      qrViewController!.resumeCamera();
      //qrViewController!.pauseCamera();
    }
    qrViewController!.resumeCamera();
    notifyListeners();
  }


  QRView createNewQRView(){
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: (result != null) ? Colors.blueAccent : Colors.greenAccent,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(navigatorKey.currentContext!, ctrl, p),
    );
  }



}