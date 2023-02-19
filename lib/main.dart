import 'package:flutter/material.dart';
import 'package:qr_generator/const.dart';
import 'package:qr_generator/models/list_page_model.dart';
import 'package:qr_generator/models/qr_page_model.dart';
import 'package:qr_generator/pages/list_client_page.dart';
import 'package:qr_generator/pages/main_page.dart';
import 'package:provider/provider.dart';
import 'package:qr_generator/pages/qr_scanner_page.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => QrPageModel()),
          ChangeNotifierProvider(create: (_) => ListPageModel()),
        ],
      child: const QrApp(),
    )
  );
}


class QrApp extends StatelessWidget {
  const QrApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings setting) {
        var routes = <String, WidgetBuilder>{
          MainPage.routeName : (context) =>const  MainPage(),
          QrScannerPage.routeName : (context) => const QrScannerPage(),
          ListClientPage.routeName : (context) => const ListClientPage()

        };


        WidgetBuilder builder = routes[setting.name]!;
        return MaterialPageRoute(builder: (context) => builder(context));
      },

      initialRoute: ListClientPage.routeName,

    );
  }
}

