import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfirebase/senend/uihelper.dart';

import 'otppage.dart';

class Phoneauth extends StatefulWidget {
  String email;
  Phoneauth({super.key,required this.email});

  @override
  State<Phoneauth> createState() => _PhoneauthState();
}

class _PhoneauthState extends State<Phoneauth> {
  final phonecontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone auth",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25),),
        centerTitle: true,
        elevation: 30,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 180,),
              Uihelper.customtextfield(phonecontroller, "Enter phone number", false, const Icon(Icons.phone,color: Colors.black,), const TextStyle(fontWeight: FontWeight.bold,color: Colors.black), 50.0, 350),
              Uihelper.custombutton(voidCallback: ()async{
              await  FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted:(PhoneAuthCredential credential) {
                    },
                    verificationFailed: (FirebaseAuthException error) {
                    },
                    codeSent: (String verificationId,int? forceResendingToken) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Otppage(verificationid: verificationId,email: widget.email),));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {
                    },
                  phoneNumber: phonecontroller.text.toString(),
                );
              }, text:const Text("authorize",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),), sizeheight: 40, sizewidth: 250),
            ],
          ),
        ),
      ),
    );
  }
}
