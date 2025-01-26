import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'otpscreen.dart';

class Phoneauth extends StatefulWidget {
  const Phoneauth({super.key});

  @override
  State<Phoneauth> createState() => Phoneauthstate();
}

class Phoneauthstate extends State<Phoneauth> {
  final otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP authentication"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
                controller: otpcontroller,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    hintText: "Enter phone number",
                    prefixIcon: Icon(Icons.phone))),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException ex) {},
                  codeSent: (String verificationid, int? resendtoken) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Otpscreen(verificationid: verificationid),
                        ));
                  },
                  codeAutoRetrievalTimeout: (String verificationid) {},
                  phoneNumber: otpcontroller.text.toString(),
                );
              },
              child: const Text("verify phone number")),
        ],
      ),
    );
  }
}
