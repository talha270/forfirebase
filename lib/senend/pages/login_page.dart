import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfirebase/senend/pages/signup.dart';
import '../uihelper.dart';
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
  if(email==""||password=="") {
    Uihelper.customalertbox(context, "Enter all the fields");
    }
  else{
    UserCredential? usercrendential;
    try{
    usercrendential= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) => Homepage(email: emailcontroller.text.toString(),),)));
    }on FirebaseAuthException catch(e){
      Uihelper.customalertbox(context, e.toString());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Text("login page",style: TextStyle(color:Colors.black,fontStyle: FontStyle.italic,fontSize: 30,fontWeight: FontWeight.bold),),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 160,),
            Uihelper.customtextfield(emailcontroller, "Enter email", false, const Icon(Icons.email,color: Colors.black,),const TextStyle(fontWeight: FontWeight.bold),50.0,320.0),
            Uihelper.customtextfield(passwordcontroller, "Enter Password", true, const Icon(Icons.password_outlined,color: Colors.black,),const TextStyle(fontWeight: FontWeight.bold),50.0,320.0),
            const SizedBox(height: 13,),
            Uihelper.custombutton(
             voidCallback: () {
               login(emailcontroller.text.toString(),passwordcontroller.text.toString());
             },
             text:  const Text("login",style:TextStyle(fontFamily: "fontst",fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black) ,),
             sizewidth: 270,
             sizeheight: 50,
            ),
            const SizedBox(height: 10,),
            Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account??",style: TextStyle(fontSize: 15),),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextButton(onPressed: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>const Signup(),));
                  }, child:const Text("Signup",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent),)),
                ),
              ],
            ),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Forgotpassword(),));
            },
                child: const Text("Forgot password??",style: TextStyle(fontSize: 18,color: Colors.blueAccent),)),
           const Text("--------continue with-------- ",style: TextStyle(fontWeight: FontWeight.bold),),
           const SizedBox(height: 15,),
            const Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               InkWell(
                 child: CircleAvatar(
                   backgroundImage: AssetImage("assets/images/Google__G__logo.svg.png"),
                  backgroundColor: Colors.white,
                   radius:20,
                 ),
               ),
               SizedBox(width:15,),
               InkWell(
                 child: CircleAvatar(
                   backgroundImage: AssetImage("assets/images/Facebook_Logo_(2019).png"),
                   backgroundColor: Colors.white,
                   radius:20,
                 ),
               ),
             ],
           )
          ],
        ),
      ),
    );
  }
}