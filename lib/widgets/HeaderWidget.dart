import 'package:flutter/material.dart';

AppBar header(context,
    {bool isAppTitle = false,
    String strTitle = "Instagram Clone",
    disappearedBackButton = false}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.grey[800],
    ),
    backgroundColor: Colors.white,
    automaticallyImplyLeading: disappearedBackButton ? false : true,
    title: Text(
      strTitle,
      style: TextStyle(color: Colors.grey[800], fontSize: 22.0),
      overflow: TextOverflow.ellipsis,
    ),
    centerTitle: true,
  );
}
