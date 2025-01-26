import 'package:flutter/material.dart';

class Uihelper {
  static customtextfield(TextEditingController textcontroller,String text,bool tohide,Icon icon,TextStyle textstyle){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: 300,
        child: TextField(
          controller: textcontroller,
          obscureText: tohide,
          obscuringCharacter: "*",
          decoration:InputDecoration(
            hintText: text,
            hintStyle: textstyle,
            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,width: 1.3),
            borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.black,width: 1.8),
            ),
            prefixIcon: icon,
          ),
        ),
      ),
    );
  }
  static custombutton({required VoidCallback voidCallback,required Text text,required double sizeheight,required double sizewidth}){
    return SizedBox(
      height: sizeheight,
      width: sizewidth,
      child: ElevatedButton(onPressed: (){
        voidCallback();
      },
        style: ElevatedButton.styleFrom(
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
              side: const BorderSide(color: Colors.black,width: 1)
            ),
          backgroundColor: Colors.white

      ),
        child:text,
      ),
    );
  }
  static customalertbox(BuildContext context,String text){
     return showDialog(context: context, builder: (context){
     return AlertDialog(
       title: Text(text),
       actions: [
         TextButton(onPressed: (){
           Navigator.pop(context);
         }, child: const Text("ok"))
       ],
     );
     });
  }
}