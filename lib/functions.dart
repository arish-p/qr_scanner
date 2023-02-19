import 'dart:convert';

import 'package:qr_generator/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/client_model.dart';



Future<List<ClientModel>> getClients() async{

  var storage = await SharedPreferences.getInstance();

  String? data = storage.getString(AppConst.storageClientsKey);

  if(data == null){
    return [];
  }else{

    List<ClientModel> clients = List.of(jsonDecode(data)['clients'])
        .map<ClientModel>((item) {
      return ClientModel.fromJson(item);
    }).toList();

    return clients;
  }

}

Future<void> saveClient(ClientModel client) async{
  var storage = await SharedPreferences.getInstance();

  List<ClientModel> clients = await getClients();
  clients.add(client);


  Map<String, List> data = Map.of(
    {
      'clients' : clients,
    }
  );


  storage.setString(AppConst.storageClientsKey, jsonEncode(data));

}


Future<void> registerClient(ClientModel client) async{
  await saveClient(client);
}