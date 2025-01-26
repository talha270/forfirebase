import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfirebase/first_login/uihelper.dart';

class Forgotpassword extends StatefulWidget{
   const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
 final TextEditingController emailcontroller = TextEditingController();
  var text="";
  forgotpassword(String email){
    if(email==""){
      Uihelper.customalertbox(context, "Enter the email to forgot the password.");
      setState(() {
        text="";
      });
    }
    else{
      setState(() {
        text="go to email and reset the password.";
      });
      try{
        FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      }on FirebaseAuthException catch(ex){
        Uihelper.customalertbox(context, ex.code.toString());
      }
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot password"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Uihelper.customtextfield(emailcontroller, "Enter email", false, const Icon(Icons.email_sharp), const TextStyle(fontFamily: "Fontst")),
            const SizedBox(
              height: 40,
            ),
            Uihelper.custombutton(
                voidCallback: () {
                  forgotpassword(emailcontroller.text.toString());
                },
                text:  const Text("Send"),
                sizeheight: 50,
              sizewidth: 260
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text,style: const TextStyle(fontFamily: "fontst",fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.deepPurple),),
            ),
          ],
        ),
      ),
    );
  }
}