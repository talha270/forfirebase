import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfirebase/senend/pages/homepage.dart';
import 'package:forfirebase/senend/pages/login_page.dart';
import 'package:forfirebase/senend/pages/phoneauth.dart';
import '../uihelper.dart';
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final firstnamecontroller=TextEditingController();
  final surnamecontroller=TextEditingController();
  final phonenumbercontroller= TextEditingController();
  final emailcontroller=TextEditingController();
  final passwordcontroller= TextEditingController();
  bool male=false;
  bool female=false;
  String checkgender="";
  bool checkterms =false;
  signup(String email,String password,String firstname,String surname,String phoneno,String gender,bool check)async{
    if(email==""||password==""||firstname==""||surname==""||phoneno==""||gender==""||check==false){
      Uihelper.customalertbox(context, "enter all required fields");
    }
    else {
      UserCredential? usercrendential;
      try{
        usercrendential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) => savedata(firstname: firstnamecontroller.text.toString(), surname: surnamecontroller.text.toString(), phone: phonenumbercontroller.text.toString(), email: emailcontroller.text.toString(), password: passwordcontroller.text.toString(), gender: checkgender));
      }on FirebaseAuthException catch(e){
        Uihelper.customalertbox(context, e.code.toString());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,size: 23,color: Colors.black,weight: 5),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Loginpage(),));
          },
        ),
        title: const Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Text("signup page",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 30,color: Colors.black),),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:  SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text("Create account ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),),
              const SizedBox(height: 21,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Uihelper.customtextfield(firstnamecontroller, "First name", false, const Icon(Icons.transit_enterexit,color: Colors.black,), const TextStyle(fontWeight: FontWeight.bold),50.0,150.0),
                Uihelper.customtextfield(surnamecontroller, "surname", false, const Icon(Icons.transit_enterexit,color: Colors.black,), const TextStyle(fontWeight: FontWeight.bold),50.0,150.0),
              ],),
              Uihelper.customtextfield(phonenumbercontroller, "Enter phone number", false, const Icon(Icons.phone,color: Colors.black,),const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),50.0,320.0),
              Uihelper.customtextfield(emailcontroller, "Enter email", false, const Icon(Icons.email,color: Colors.black,),const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),50.0,320.0),
              Uihelper.customtextfield(passwordcontroller, "New Password", true, const Icon(Icons.password_outlined,color: Colors.black,),const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),50.0,320.0),
              const SizedBox(height: 4,),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left:  42),
                    child: Text("Gender :     Male",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  Checkbox(value:male , onChanged:(change){
                    setState(() {
                      if(female==false) {
                        male = change!;
                        if(change==true) {
                          checkgender ="male";
                        }
                        if(change==false){checkgender="";}
                        }
                    });
                  },activeColor: Colors.greenAccent, ),
                  const Text(" Female",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Checkbox(value:female , onChanged:(change){
                    setState(() {
                      if(male==false) {
                        female = change!;
                        if(change==true) {
                          checkgender ="female";
                        }
                        if(change==false){checkgender="";}
                      }
                    });
                  },activeColor: Colors.greenAccent, ),
                ],
              ),
             Row(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(left: 30),
                   child: Checkbox(value: checkterms, onChanged: (change){setState(() {
                     checkterms=change!;
                   });
                   },
                     activeColor: Colors.greenAccent,
                   ),
                 ),
                 const Text("Check the",style: TextStyle(fontWeight: FontWeight.bold),),
                 const Text(" term",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent),),
                 const Text(" and",style: TextStyle(fontWeight: FontWeight.bold),),
                 const Text(" policy........ ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent),)
               ],
             ),
              const SizedBox(height: 19,),
              Uihelper.custombutton(
                  voidCallback: () {
                    signup(emailcontroller.text.toString(), passwordcontroller.text.toString(),firstnamecontroller.text.toString(),surnamecontroller.text.toString(),phonenumbercontroller.text.toString(),checkgender,checkterms);
                  },
                  text: const Text("signup",style:TextStyle(fontFamily: "fontst",fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
                  sizeheight: 50,
                  sizewidth: 200
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      )
    );
  }
  savedata({required String firstname,required String surname,required String phone,required String email,required String password,required String gender,}){

    FirebaseFirestore.instance.collection("Users").doc("information").set({
      "firstname": firstname,
      "surname": surname,
      "phone-number": phone,
      "email": email,
      "password":password,
      "gender": gender,
    }).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage(email: email,),)));
  }
}
