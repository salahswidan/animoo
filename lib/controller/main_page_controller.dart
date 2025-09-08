import 'dart:async';

import 'package:animoo/view/main_page/category/screen/category_page.dart';
import 'package:animoo/view/main_page/home/screen/home_page.dart';
import 'package:flutter/material.dart';

import 'category_page_controller.dart';

class MainPageController {
  BuildContext context;
  int _currentIndex = 0;

  late StreamController<int> currentIndexStreamController;
  late Stream<int> currentIndexOutputStream;
  late Sink<int> currentIndexInput;

  List<Widget?> pages = List.filled(5, null);
  List<bool> hasVisited = List.filled(5, false);
  CategoryPageController? categoryPageController;

  late final PageController pageController;

  Widget buildWidget(int index) {
    if (!hasVisited[index]) {
      print("building page$index");
      hasVisited[index] = true;
      switch (index) {
        case 0:
          pages[index] = HomePage();
          break;
        case 1:
          //  categoryPageController ??= CategoryPageController(context);
          pages[index] = Scaffold(body: Center(child: Text("Search")));
          break;
        case 2:
          categoryPageController ??= CategoryPageController(context);
          pages[index] = CategoryPage();
          break;

        case 3:
          categoryPageController ??= CategoryPageController(context);
          pages[index] = Scaffold(body: Center(child: Text("Animal")));
          break;
        case 4:
          categoryPageController ??= CategoryPageController(context);
          pages[index] = Scaffold(body: Center(child: Text("Me")));
          break;
      }
    }
    return pages[index]!;
  }

  MainPageController(this.context) {
    init();
  }

  void init() {
    initStream();
    pageController = PageController(initialPage: _currentIndex);
  }

  void initStream() {
    currentIndexStreamController = StreamController<int>.broadcast();
    currentIndexOutputStream = currentIndexStreamController.stream;
    currentIndexInput = currentIndexStreamController.sink;
  }

  void dispose() {
    disposeStream();
    //? dispose other controllers dispose method
    categoryPageController?.dispose();
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
