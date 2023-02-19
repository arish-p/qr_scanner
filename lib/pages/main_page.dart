import 'package:flutter/material.dart';
import 'package:qr_generator/pages/qr_scanner_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  static const routeName = 'mainPage';


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: QrScannerPage(),
    );
  }
}
