import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mikhvision/homepage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
);

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Image? img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/signup_image.png',
              height: 150,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Lets get Started!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Create an account',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            if (img == null)
              const Text(
                'Click below to upload a profile picture',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 150,
              height: 150,
              child: img ??
                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.blue),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        size: 60,
                        color: Colors.blue,
                      ),
                    ),
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      XFile? xfile =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (xfile != null) {
                        img = await xFileToImage(xfile);
                        setState(() {});
                      }
                    },
                  ),
            ),
            if (img != null)
              TextButton(
                onPressed: () {
                  setState(() {
                    img = null;
                  });
                },
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      img = null;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text(
                      'Remove Image',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
              ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'If Image is not provided, it is taken\nfrom the associated Google Account',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            TextButton(
              onPressed: () {
                _signin(context);
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(18)),
                child: const Text(
                  'Continue with Google',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signin(context) async {
    GoogleSignInAccount? account;

    try {
      account = await _googleSignIn.signIn();
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
      );
    }

    if (account != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(account!, image: img),
        ),
      );
    }
  }

  Future<Image> xFileToImage(XFile xFile) async {
    return Image.file(File(xFile.path));
  }
}
