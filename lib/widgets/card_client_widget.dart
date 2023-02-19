import 'package:flutter/material.dart';
import 'package:qr_generator/models/client_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardClientWidget extends StatelessWidget {
  const CardClientWidget({Key? key, required this.client}) : super(key: key);

  final ClientModel client;

  final TextStyle headerStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  final TextStyle bodyStyle = const TextStyle(
    color: Colors.blueAccent,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  final TextStyle bodyStyleWeight = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0,4)
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(client.name.toString(), style: headerStyle,),
            const SizedBox(height: 8,),
            Text(client.position.toString(), style: bodyStyle,),
            const SizedBox(height: 10,),
            Row(
              children: [
                SvgPicture.asset('assets/svg/phone.svg'),
                const SizedBox(width: 5,),
                Text(client.number.toString(), style: bodyStyleWeight,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
