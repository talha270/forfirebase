import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfirebase/senend/pages/homepage.dart';
import 'package:forfirebase/senend/uihelper.dart';

class Otppage extends StatefulWidget {
  String verificationid;
  String email;
  Otppage({super.key,required this.verificationid,required this.email});

  @override
  State<Otppage> createState() => _OtppageState();
}

class _OtppageState extends State<Otppage> {
  final codecontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTP AUTH"),
      centerTitle: true,
      backgroundColor: Colors.white,
        elevation: 30,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 180,),
            Uihelper.customtextfield(codecontroller, "Enter the code", false, const Icon(Icons.qr_code_scanner_sharp,color: Colors.black,), const TextStyle(fontWeight: FontWeight.bold,color: Colors.black), 50, 350),
            Uihelper.custombutton(voidCallback: ()async{
              try {
                PhoneAuthCredential credential = await PhoneAuthProvider
                    .credential(verificationId: widget.verificationid,
                    smsCode: codecontroller.text.toString());
                FirebaseAuth.instance.signInWithCredential(credential).then((
                    value) =>
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) =>Homepage(email: widget.email,),)));
              }catch(e){
                Uihelper.customalertbox(context, e.toString());
              }
              },
                text: const Text("Check",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),), sizeheight: 40, sizewidth: 300),
          ],
        ),
      ),
    );
  }
}
