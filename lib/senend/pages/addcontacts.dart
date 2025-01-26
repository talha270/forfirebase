import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfirebase/senend/uihelper.dart';

class Addcontact extends StatefulWidget {
  const Addcontact({super.key});

  @override
  State<Addcontact> createState() => _AddcontactState();
}

class _AddcontactState extends State<Addcontact> {
  final namecontroller= TextEditingController();
  final nocontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add contact",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Uihelper.customtextfield(namecontroller, "Enter Name", false, const Icon(Icons.transit_enterexit,color: Colors.black,), const TextStyle(fontWeight: FontWeight.bold), 50, 320),
            Uihelper.customtextfield(nocontroller, "Enter phone number", false, const Icon(Icons.phone,color: Colors.black,), const TextStyle(fontWeight: FontWeight.bold), 50, 320),
            const SizedBox(height:22),
            Uihelper.custombutton(voidCallback: (){
            add(namecontroller.text.toString(), nocontroller.text.toString());
            }, text: const Text("Add",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),), sizeheight: 40, sizewidth: 300),
          ],
        ),
      ),
    );
  }
  add(String name,String phone){
    FirebaseFirestore.instance.collection("Usercontacts").doc(name).set({
      "name": name,
      "phone number": phone
    }).then((value) => Navigator.pop(context));
  }
}
