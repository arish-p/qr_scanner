import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_generator/dialogs/dialogs.dart';
import 'package:qr_generator/models/client_model.dart';
import 'package:qr_generator/models/qr_page_model.dart';
import 'package:qr_generator/pages/ciient_info_page.dart';

class QrScannerPage extends StatelessWidget {
  const QrScannerPage({Key? key}) : super(key: key);

  static const String routeName = "qrScannerPage";

  @override
  Widget build(BuildContext context) {
    ClientModel? result = context.watch<QrPageModel>().result;
    Widget? qrView = context.watch<QrPageModel>().qrView;

    if (result == null) {
      return Stack(
        children: [
          qrView!,
          const Padding(
            padding: EdgeInsets.only(top: 300),
            child: Center(
              child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "Наведите камеру на QR-код",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
            ),
          )
        ],
      );
    } else {
      return ClientInfoPage(client: result);
    }
  }
}
