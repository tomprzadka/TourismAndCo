// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../styles.dart';

class DefaultAppBar extends AppBar {
  DefaultAppBar()
      : super(
            title: (Text("Tourism & Co.".toUpperCase(),
                style: Styles.navBarTitle)),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0.5,
            iconTheme: const IconThemeData(color: Colors.black));

  // code below should not be used as it overrides fields from AppBar instead of setters and getters
  // @override
  // final Widget title = (Text("Tourism & Co.".toUpperCase(),
  //     style: Styles.navBarTitle));

  // @override
  // final Color backgroundColor = Colors.white;

  // @override
  // final bool centerTitle = true;

  // @override
  // final double elevation = 0.5;
}
