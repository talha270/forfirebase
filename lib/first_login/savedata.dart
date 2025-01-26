import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfirebase/first_login/uihelper.dart';

import 'homepage.dart';

class Savedata extends StatefulWidget{
  const Savedata({super.key});

  @override
  State<Savedata> createState()=> Savedatastate();
}
class Savedatastate extends State<Savedata>{
  final namecontroller=TextEditingController();
  final fathernamecontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FireStore",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Uihelper.customtextfield(namecontroller, "Enter the name", false, const Icon(Icons.near_me), const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            Uihelper.customtextfield(fathernamecontroller, "Enter the father name", false, const Icon(Icons.near_me), const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 11,),
            Uihelper.custombutton(voidCallback: (){
              savestore(namecontroller.text.toString(), fathernamecontroller.text.toString());
            },
                text:const Text("Save data",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                sizeheight: 50, sizewidth: 200),
          ],
        ),
      ),

    );
  }
  savestore(String name,String fathername){
    if(name==""||fathername=="") {
      Uihelper.customalertbox(context, "Enter all the fields");
       }
    else{
      FirebaseFirestore.instance.collection("Information").doc("user").set({
        "name ": name,
        "fathername":fathername,
      }).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Homepage(),)));
    }
    }
}