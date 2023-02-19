import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_generator/models/client_model.dart';
import 'package:qr_generator/models/list_page_model.dart';
import 'package:qr_generator/pages/qr_scanner_page.dart';
import 'package:qr_generator/widgets/card_client_widget.dart';
import 'package:qr_generator/widgets/custom_buttons.dart';

class ListClientPage extends StatefulWidget {
  const ListClientPage({Key? key}) : super(key: key);

  static const String routeName = 'listClientPage';

  @override
  State<ListClientPage> createState() => _ListClientPageState();
}


class _ListClientPageState extends State<ListClientPage> {

  final ScrollController _scrollController = ScrollController();
  final bodyStyle = const TextStyle(fontSize: 14, color: Colors.black38);
  final bodyStyleWeight700 = const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700);
  bool _showButton = true;

  @override
  void initState() {
    _scrollController.addListener(() {
      if(_scrollController.position.atEdge){
        if(_scrollController.position.pixels>0){
          if(_showButton){
            setState(() {
              _showButton = false;
            });
          }
        }
      }
      else{
        if(!_showButton){
          setState(() {
            _showButton = true;
          });
        }
      }

    });
    context.read<ListPageModel>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    bool showData = context.watch<ListPageModel>().showData;


    if(showData == true){
      List<ClientModel>? clients = context.read<ListPageModel>().clients;

      clients  = List.of(clients!.reversed);

      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Container(

                  padding:  const EdgeInsets.only(right: 16, left: 16),
                  color: Colors.white,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/png/logo.png', scale: 15,),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 21, left: 16, right: 16, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (clients.isNotEmpty) ? Text('Всего зарегестрированных: ', style:  bodyStyle) : const SizedBox(),
                        const SizedBox(height: 8, ),
                        (clients.isNotEmpty) ? Text('${clients.length}', style:  bodyStyleWeight700) : const SizedBox(),
                      ],
                    ),
                  ),
                ),

                (clients.isNotEmpty) ? Expanded(
                  child: Container(
                      color: Colors.grey.shade100,
                    child: ListView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        controller: _scrollController,
                        itemCount: clients.length,
                        itemBuilder: (context, int index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                            child: CardClientWidget(client: clients![index]),
                          );
                        }
                    ),
                  ),
                ) : Container(
                    color: Colors.grey.shade100,
                    child: const Center(child: Text("Здесь будет информация о участниках"))),
              ],
            ),
            Positioned(
                top: MediaQuery.of(context).size.height/1.2,
                left: 35,
                right: 35,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child: (_showButton) ? CustomTextButton(onTap: (){
                    Navigator.pushNamed(context,QrScannerPage.routeName);
                  }, color: Colors.blueAccent, text: "Сканировать QR-код") : const SizedBox()
                )),
          ],
        ),
      );

    }else{
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(),),
      );
    }

    return Scaffold(
      body: Container(),
    );
  }
}
