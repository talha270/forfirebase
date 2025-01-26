import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfirebase/senend/pages/login_page.dart';

import '../uihelper.dart';

class Forgotpassword extends StatefulWidget{
   const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
 final TextEditingController emailcontroller = TextEditingController();
    forwordpassword(String email){
      if(email==""){
        Uihelper.customalertbox(context, "Enter email");
      }
      else{
        try{
          FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        }on FirebaseAuthException catch(ex){
          Uihelper.customalertbox(context, ex.toString());
        }
      }
    }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed:(){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Loginpage(),));},
            icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: const Text("Forgot password",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 20,
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 180,),
            Uihelper.customtextfield(emailcontroller, "Enter email", false, const Icon(Icons.email_sharp,color: Colors.black,), const TextStyle(color: Colors.black),50.0,320.0),
            // SizedBox(height: 10,),
            const SizedBox(
              height: 15,
            ),
            Uihelper.custombutton(
                voidCallback: () {
                  forwordpassword(emailcontroller.text.toString());
                },
                text:  const Text("Send code",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                sizeheight: 50,
              sizewidth: 260
            ),
          ],
        ),
      ),
    );
  }
}