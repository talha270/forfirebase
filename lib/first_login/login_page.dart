import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forfirebase/first_login/signup.dart';
import 'package:forfirebase/first_login/uihelper.dart';

import 'forgotpassword.dart';
import 'homepage.dart';
class Loginpage extends StatefulWidget{
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController emailcontroller=TextEditingController();

  final TextEditingController passwordcontroller=TextEditingController();

  login(String email,String password)async{
    if(email==""&&password==""){
      Uihelper.customalertbox(context, "Enter all fields");
    }
    else{
      UserCredential? usercrendential;
      try{
        //signInWithEmailAndPassword is used for login
        usercrendential= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Homepage(),)));
      }
      on FirebaseAuthException catch(ex){
        return Uihelper.customalertbox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Text("login page",style: TextStyle(color:Colors.black,fontFamily: "fontst",fontStyle: FontStyle.italic,fontSize: 30),),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:  SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 160,),
            Uihelper.customtextfield(emailcontroller, "Enter email", false, const Icon(Icons.email,color: Colors.black,),const TextStyle(fontWeight: FontWeight.bold)),
            Uihelper.customtextfield(passwordcontroller, "Enter Password", true, const Icon(Icons.password_outlined,color: Colors.black,),const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 11,),
            Uihelper.custombutton(
             voidCallback: () { login(emailcontroller.text.toString(), passwordcontroller.text.toString());},
             text:  const Text("login",style:TextStyle(fontFamily: "fontst",fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black) ,),
             sizewidth: 260,
             sizeheight: 50,
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account??",style: TextStyle(fontSize: 15),),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextButton(onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const Signup(),));
                  }, child:const Text("Signup",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent),)),
                ),
              ],
            ),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Forgotpassword(),));
            },
                child: const Text("Forgot password??",style: TextStyle(fontSize: 18,color: Colors.blueAccent),)),
          ],
        ),
      ),
    );
  }
}