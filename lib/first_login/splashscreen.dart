import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';
import 'login_page.dart';

class Splashscreen extends StatefulWidget{
  const Splashscreen({super.key});
  @override
  State<Splashscreen> createState()=>Splashscreenstate();
}
class Splashscreenstate extends State<Splashscreen>{
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>checkuser() ,));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.deepPurple.shade400,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.ac_unit,size: 50,),
            Text("Fire base",style: TextStyle(fontFamily: "fontst",fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 30),),
          ],
        ),
      ),
    );
  }

  checkuser() {
    final user= FirebaseAuth.instance.currentUser;
    if(user!=null){
      return const Homepage();
    }
    else{
      return const Loginpage();
    }
  }
}
