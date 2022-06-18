import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mikhvision/signup.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage(this.account, {Key? key, this.image}) : super(key: key);

  final GoogleSignInAccount account;
  Image? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 6,
        title: const Text('My App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _logOut(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.logout),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            image != null
                ? SizedBox(
                    width: 150,
                    height: 150,
                    child: image,
                  )
                : CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      account.photoUrl!,
                    ),
                  ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'You are successfully logged in the app',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(
              height: 30,
            ),
            Text('Email: ${account.email}'),
            const SizedBox(
              height: 20,
            ),
            Text('Name: ${account.displayName}'),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Floating Action Button logs out the user',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<void> _logOut(context) async {
    await _googleSignIn.signOut().catchError((e) {
      log(e);
    });

    Fluttertoast.showToast(
      msg: 'Signed out successfully',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupPage(),
      ),
    );
  }
}
