import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forfirebase/senend/pages/login_page.dart';

class Splashscreen extends StatefulWidget{
  const Splashscreen({super.key});
  @override
  State<Splashscreen> createState()=>Splashscreenstate();
}
class Splashscreenstate extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Loginpage(),));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.ac_unit_rounded,size: 70,),
            Text("Classical", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 40),),
          ],
        ),
      ),
    );
  }
}