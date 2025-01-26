import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfirebase/senend/pages/addcontacts.dart';
import 'package:forfirebase/senend/pages/login_page.dart';

class Homepage extends StatefulWidget {
  String email;
  Homepage({super.key,required this.email});

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
      appBar: AppBar(
        leading:
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu, color: Colors.black,),
                );
              }
        ),
        backgroundColor: Colors.white,
        title: const Text("Home page",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87),),
      elevation: 30,
      centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 5,right: 5),
            child: Card(
              elevation: 10,
              child: SizedBox(
                  height: 60,
                  child: ListTile(
                    title: const Text("Search",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black26),),
                    trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: Colors.black45,)),
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5,left: 5,right: 5),
            child: Card(
              elevation: 10,
              child: SizedBox(
                  height: 60,
                  child: ListTile(
                    title: const Text("Add contact",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black26),),
                    trailing: IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Addcontact(),));
                    }, icon: const Icon(Icons.add,color: Colors.black45,)),
                  )
              ),
            ),
          ),
          contactlist(),

        ],
      ),
      drawer:Drawer(
      elevation: 30,
        width: 300,

        child: Column(children: [
          const SizedBox(height: 50,),
          const ListTile(
            leading: CircleAvatar(radius: 30,
              child:
              Icon(Icons.person,size: 40,),
            ),
            title: Text("My Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
          ),
          InkWell(
            onTap: (){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage(email: widget.email,),));
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 30,top: 20),
              child: Row(
                children: [
                  Icon(Icons.home,color: Colors.black,size: 30,),
                  SizedBox(width: 10,),
                  Text("Home",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              settings();},
            child: const Padding(
              padding: EdgeInsets.only(left: 33,top: 10),
              child: Row(
                children: [
                  Icon(Icons.settings,color: Colors.black,size: 30,),
                  SizedBox(width: 10,),
                  Text("Settings",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ],
              ),
            ),
          ),
        ],),
      ),
    );
  }
  settings(){
    return showDialog(context: context,builder:(context){
      return AlertDialog(
        title: const Text("Settings"),
        elevation: 30,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text("you want to logout??"),
                const SizedBox(width: 30,),
                IconButton(
                    onPressed: (){
                      logout();
                    },
                    icon: const Icon(Icons.logout)),
              ],
            )
          ],
        ),
      );
    } );
  }
  contactlist(){
    return StreamBuilder(stream: FirebaseFirestore.instance.collection("Usercontacts").snapshots(),
        builder:(context, snapshot) {
          if(snapshot.connectionState==ConnectionState.active){
            if(snapshot.hasData){
              // print("data");
              return SizedBox(
                height: 545,
                child: ListView.builder(itemBuilder: (context, index) => ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text("${snapshot.data!.docs[index]["name"]}"),
                  subtitle: Text(snapshot.data!.docs[index]["phone number"]),
                  trailing: IconButton(onPressed: (){},
                      icon: const Icon(Icons.phone)),
                ),
                itemCount: snapshot.data!.docs.length,
                ),
              );
            }
            else if(snapshot.hasError){
              // print("error");
              return Center( child: Text(snapshot.hasError.toString()),);
            }
            else{
              // print("no any data");
            return const Center(child: Text("No any contact"),);
            }
          }
          else{
            // print("else");
            return const Center(child: CircularProgressIndicator());
          }
        },
    );
  }
}
