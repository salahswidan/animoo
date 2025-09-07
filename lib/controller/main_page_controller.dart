import 'dart:async';

import 'package:animoo/view/main_page/category/screen/category_page.dart';
import 'package:animoo/view/main_page/home/screen/home_page.dart';
import 'package:flutter/material.dart';

class MainPageController {
  int _currentIndex = 0;

  late StreamController<int> currentIndexStreamController;
  late Stream<int> currentIndexOutputStream;
  late Sink<int> currentIndexInput;

  List<Widget> pages = [
    HomePage(),
    Scaffold(body: Center(child: Text("Search Page"))),

    CategoryPage(),
    Scaffold(body: Center(child: Text("Animals Page"))),
    Scaffold(body: Center(child: Text("Profile Page"))),
  ];

  MainPageController() {
    init();
  }

  void init() {
    initStream();
  }

  void initStream() {
    currentIndexStreamController = StreamController<int>.broadcast();
    currentIndexOutputStream = currentIndexStreamController.stream;
    currentIndexInput = currentIndexStreamController.sink;
  }

  void dispose() {
    disposeStream();
  }

  void disposeStream() {
    currentIndexStreamController.close();
    currentIndexInput.close();
  }

  void onTapBottomNavigationBarItem(int value) {
    _currentIndex = value;
    currentIndexInput.add(value);
  }
}
