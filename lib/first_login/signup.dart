import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:forfirebase/first_login/uihelper.dart';
import 'package:image_picker/image_picker.dart';
import 'homepage.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailcontroller=TextEditingController();
  final TextEditingController passwordcontroller= TextEditingController();
  File? pickedimage;
  signup(String email,String password)async{
    if(email=="" || password==""|| pickedimage==null){
      Uihelper.customalertbox(context, "enter all fields and photo");
    }
    else{
      UserCredential ? usercredential;
      try{
        // createUserWithEmailAndPassword is used for create account
        usercredential =await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email , password: password).then((value) => uploaddata());
      }
      on FirebaseAuthException catch(ex){
        return Uihelper.customalertbox(context, ex.code.toString());
      }
    }
  }
  showdial(){
    return showDialog(context: context, builder: (context) =>AlertDialog(
      title: const Text("pick the images from"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading:const Icon(Icons.camera_alt),
            title: const Text("camera"),
            onTap: (){
              pickimages(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text("Gallery"),
            onTap: (){
              pickimages(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Text("signup page",style: TextStyle(fontFamily: "fontst",fontStyle: FontStyle.italic,fontSize: 30,color: Colors.black),),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                showdial();
              },
              child:pickedimage!=null?
              CircleAvatar(
                radius: 70,
                backgroundImage: FileImage(pickedimage!),
              ):
              const CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,

                  child: Icon(Icons.person,size: 170,color:Colors.black,),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Uihelper.customtextfield(emailcontroller, "Enter email", false, const Icon(Icons.email),const TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
            Uihelper.customtextfield(passwordcontroller, "Enter Password", true, const Icon(Icons.password_outlined),const TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
            const SizedBox(height: 21,),
            Uihelper.custombutton(
                voidCallback: () {
              signup(emailcontroller.text.toString(), passwordcontroller.text.toString());},
              text: const Text("signup",style:TextStyle(fontFamily: "fontst",fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
              sizeheight: 50,
              sizewidth: 200
            ),
            const SizedBox(height: 20,),
          ],
        ),
      )
    );
  }
  pickimages(ImageSource imageSource)async{
      try {
        final photo=await ImagePicker().pickImage(source: imageSource);
        if(photo==null) return;
          // final locationofphoto =
          setState(() {
            // pickedimage= locationofphoto;
            pickedimage= File(photo.path);
          });
        }catch(ex){
        return Center(child: Text(ex.toString()),);
      }
      }
      uploaddata()async{
      UploadTask uploadTask=FirebaseStorage.instance.ref("profile pics").child(emailcontroller.text.toString()).putFile(pickedimage!);
      TaskSnapshot taskSnapshot=await uploadTask;  //this is used for url of photo
      String url=await taskSnapshot.ref.getDownloadURL();
      FirebaseFirestore.instance.collection("Users").doc(emailcontroller.text.toString()).set({
      "email": emailcontroller.text.toString(),
       "image": url,
      }).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Homepage())));
      }
}
