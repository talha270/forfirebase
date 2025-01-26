import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class Homepage extends StatefulWidget{
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  logout()async{
    await FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Loginpage(),)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        actions: [
          IconButton(onPressed: (){logout();},
              icon: const Icon(Icons.leave_bags_at_home)),
        ],
        centerTitle: true,
        title: const Text ("Home"),

      ),
      drawer: const Drawer(
       child: Column(
         children: [
         ],
       ),
      ),
      body:Center(child: Builder(
        builder: (context) {
          return ElevatedButton(
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
              child: const Text("open drawer"));
        },
      )),
    );
  }
}