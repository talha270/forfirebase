import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Fetchdata extends StatefulWidget{
  const Fetchdata({super.key});

  @override
  State<Fetchdata> createState()=> Fetchdatastate();
}
class Fetchdatastate extends State<Fetchdata>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("contacts",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:StreamBuilder(
          stream:FirebaseFirestore.instance.collection("Users").snapshots() ,
          builder:(context,snapshot){
            if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.hasData){
                return ListView.builder(itemBuilder: (context, index) => Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text("${index+1}"),
                      ),
                      title: Text("${snapshot.data!.docs[index]["name"]}"),
                      subtitle: Text("${snapshot.data!.docs[index]["number"]}"),
                      trailing: const Icon(Icons.phone),
                    ),
                  ),
                ),
                itemCount: snapshot.data!.docs.length,
                );
              }
              else if(snapshot.hasError){
                return Center(child: Text(snapshot.hasError.toString()),);
              }
              else{  //else is worked when no data at firestore
                return const Center(child: Text("data has not found "),);
              }
            }
            else{
              return const Center(child: CircularProgressIndicator(),);
            }
          })  ,
    ) ;
  }
}