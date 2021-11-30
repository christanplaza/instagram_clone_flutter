import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSignedIn = false;

  Widget buildHomeScreen() {
    return const Text("You are now Signed In");
  }

  Scaffold buildSignInScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: 
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Instagram Clone",
                style: TextStyle(fontSize: 32.0, color: Colors.black)),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Center(
                  child: Text("Sign in with Google"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return buildHomeScreen();
    } else {
      return buildSignInScreen();
    }
  }
}
