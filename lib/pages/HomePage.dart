import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone/pages/SearchPage.dart';
import 'package:instagram_clone/pages/UploadPage.dart';
import 'package:instagram_clone/pages/ProfilePage.dart';
import 'package:instagram_clone/pages/TimelinePage.dart';
import 'package:instagram_clone/pages/NotificationsPage.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
]);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleSignInAccount? _currentUser;
  late PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();

    pageController = PageController();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });

      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });

    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount signInAccount) async {
    await saveUserInfoToFireStore();
  }

  saveUserInfoToFireStore() async {
    final GoogleSignInAccount? gCurrentUser = _googleSignIn.currentUser;
  }

  Future<void> loginUser() async {
    await _googleSignIn.signIn();
  }

  Future<void> logoutUser() async {
    _googleSignIn.disconnect();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  whenPageChanges(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTapChangePage(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.bounceInOut);
  }

  Widget _buildBody() {
    GoogleSignInAccount? user = _currentUser;

    if (user != null) {
      return Scaffold(
        body: PageView(
          children: const [
            TimelinePage(),
            SearchPage(),
            UploadPage(),
            NotificationsPage(),
            ProfilePage(),
          ],
          controller: pageController,
          onPageChanged: whenPageChanges,
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onTapChangePage,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home)),
            BottomNavigationBarItem(icon: Icon(Icons.search)),
            BottomNavigationBarItem(icon: Icon(Icons.photo_camera)),
            BottomNavigationBarItem(icon: Icon(Icons.favorite)),
            BottomNavigationBarItem(icon: Icon(Icons.person)),
          ],
        ),
      );
      // return Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     const Text("Instagram Clone",
      //         style: TextStyle(fontSize: 32.0, color: Colors.black)),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
      //       child: Text("Hello, ${user.displayName}"),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
      //       child: ElevatedButton(
      //         onPressed: logoutUser,
      //         child: const Center(
      //           child: Text("Logout"),
      //         ),
      //       ),
      //     ),
      //   ],
      // );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Instagram Clone",
              style: TextStyle(fontSize: 32.0, color: Colors.black)),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
            child: ElevatedButton(
              onPressed: loginUser,
              child: const Center(
                child: Text("Sign in with Google"),
              ),
            ),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black, Colors.white]),
        ),
        child: _buildBody(),
      ),
    );
  }
}
