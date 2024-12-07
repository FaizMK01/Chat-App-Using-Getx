import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UserTile extends StatelessWidget {
  final String text;
  final VoidCallback tap;
  const UserTile({super.key, required this.text, required this.tap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
       child: Container(
         height: 70,
         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
         margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
         decoration: BoxDecoration(
           color: Theme.of(context).colorScheme.secondary,
           borderRadius: BorderRadius.circular(10)
         ),
         child: Row(
           children: [
             Icon(Icons.person),
             Gap(5),
             Text(text)
           ],

         ),
       ),
    );
  }
}
