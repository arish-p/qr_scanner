import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_generator/const.dart';
import 'package:qr_generator/dialogs/dialogs.dart';
import 'package:qr_generator/functions.dart';
import 'package:qr_generator/models/list_page_model.dart';
import 'package:qr_generator/models/qr_page_model.dart';
import 'package:qr_generator/widgets/card_client_widget.dart';
import 'package:qr_generator/widgets/custom_buttons.dart';

import '../models/client_model.dart';

class ClientInfoPage extends StatelessWidget {
  final ClientModel client;
  final divider = const SizedBox(height: 8);

  const ClientInfoPage({Key? key, required this.client}) : super(key: key);
  final TextStyle headerStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<QrPageModel>().reset();

        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: PreferredSize(
            preferredSize: Size(0,85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('Участник', style: headerStyle,))
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CardClientWidget(client: client),
                Column(
                  children: [
                    CustomTextButton(onTap: () async{
                      ListPageModel listClientPAge = context.read<ListPageModel>();
                      await registerClient(client);
                      listClientPAge.updateData();
                      showExitDialog(navigatorKey.currentContext!);
                    }, color: Colors.blueAccent, text: "Зарегистрировать"),
                    divider,
                    CustomTextButton(onTap: (){
                      context.read<QrPageModel>().reset();
                    }, color: Colors.white, text: "Отмена", textColor: Colors.black,),
                  ],
                )

              ],
            ),
          ),
      ),
    );
  }
}
