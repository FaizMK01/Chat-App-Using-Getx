import 'package:chat_app/Views/blockUserPage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.transparent,
        foregroundColor:Colors.grey,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Gap(20),

            Container(
                height: 80,
                width: double.infinity,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)


                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Blocked User",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                    ),),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>BlockUserPage()));
                    //  Get.to(()=>BlockUserPage());
                    }, icon: Icon(Icons.arrow_forward_ios,size: 30,))
                  ],
                )
            ),

          ],
        )
      ),
    );
  }
}
