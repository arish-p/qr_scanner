import 'package:flutter/material.dart';
import '../functions.dart';
import 'client_model.dart';

class ListPageModel with ChangeNotifier{
  List<ClientModel>? clients;
  bool showData = false;
  bool showButton = true;
  final ScrollController scrollController = ScrollController();


  void getData() async{
    clients = await getClients();
    showData = true;
    notifyListeners();
  }

  void updateData() async{
    showData = false;
    notifyListeners();
    clients = await getClients();
    showData = true;
    notifyListeners();
  }

  bool listenShowButton(){
    if(scrollController.position.atEdge){
      if(scrollController.position.pixels>0){
        if(showButton){
            showButton = false;
            return showButton;
        }
      }
    }
    else{
      if(!showButton){
        showButton = true;
        return showButton;
      }
    }
    return showButton;

  }

}