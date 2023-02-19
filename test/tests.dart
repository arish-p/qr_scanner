import 'package:flutter_test/flutter_test.dart';
import 'package:qr_generator/functions.dart';
import 'package:qr_generator/models/client_model.dart';


void main () {
  test("память", ()async {

    await saveClient(ClientModel(
      name: 'Диас',
      number: '9821-0481-',
      position: 'org'
    ));
    await saveClient(ClientModel(
        name: 'Диас',
        number: '9821-0481-',
        position: 'org'
    ));

   var clients =  await getClients();

   print(clients.toString());
  });
}