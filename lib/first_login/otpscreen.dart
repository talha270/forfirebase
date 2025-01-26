
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class Otpscreen extends StatefulWidget{
  final String verificationid;
  const Otpscreen({super.key,required this.verificationid});

  @override 
  State<Otpscreen> createState()=> Otpscreenstate();
}
class Otpscreenstate extends State<Otpscreen>{
  final otpcontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
            controller: otpcontroller,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: "enter the otp",
              prefixIcon: Icon(Icons.phone),
            ),
            ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: 200,
            child: ElevatedButton(onPressed: ()async{
              try{
                PhoneAuthCredential credential=await PhoneAuthProvider.credential(
                    verificationId: widget.verificationid,
                    smsCode: otpcontroller.text.toString());
                    FirebaseAuth.instance.signInWithCredential(credential).then((value) => Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => const Homepage(),)));
              } catch(ex){
              }
            },
                child: const Text("OTP")),
          ),
        ],
      ),
    );
  }
}