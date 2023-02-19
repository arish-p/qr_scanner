import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_generator/const.dart';
import 'package:qr_generator/models/qr_page_model.dart';
import 'package:qr_generator/pages/list_client_page.dart';
import 'package:qr_generator/pages/main_page.dart';
import 'package:qr_generator/widgets/custom_buttons.dart';

void showExitDialog(context){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return WillPopScope(
          onWillPop: ()async{
           Navigator.pop(context);
           Navigator.pushReplacementNamed(context,  ListClientPage.routeName);
           context.read<QrPageModel>().reset();
           return false;
          },
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14))
            ),
            title: const Text(
              "Участник зарегистрирован",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    CustomTextButton(
                        onTap: (){
                          Navigator.pushNamedAndRemoveUntil(context, ListClientPage.routeName, (route) => false);
                          context.read<QrPageModel>().reset();
                        },
                        color: Colors.grey.shade200,
                        text: "Вернуться на главную",
                        height: 40,
                        fontSize: 14,
                        textColor: Colors.black,
                        onShadow: false,
                    ),
                  ],
                ),
              ),
            ],
            titlePadding: const EdgeInsets.only(top:30, bottom: 30, left: 16, right: 16),
            actionsPadding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
          ),
        );
      }
  ).then((value) {
    context.read<QrPageModel>().reset();
    Navigator.pushReplacementNamed(context, ListClientPage.routeName);
  });
}

Future<void> showErrorDialog({required String textError}) async {
  await showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          title: const Text(
            "Ошибка",
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          actionsPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child:  Center(
                      child: Text(
                        textError,
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    )),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Заново",
                            style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(context, ListClientPage.routeName, (route) => false);
                          },
                          child: const Text(
                            "Вернуться на главную",
                            style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                            textAlign: TextAlign.start,
                          )),
                    ),
                  ],
                ),
              ],
            )
          ],
        );
      });
}


class ErrorSnackBar {
  late SnackBar snackBar;

  ErrorSnackBar({required String error}){
   snackBar = SnackBar(
     backgroundColor: Colors.red,
     content: Text(error),
     action: SnackBarAction(
       label: 'Вернуться',
       onPressed: () {

       },
     ),
   );

  }
}

