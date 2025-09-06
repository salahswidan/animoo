import 'package:animoo/core/resources/colors_manager.dart';
import 'package:animoo/core/widgets/spacing/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/home_page_animals.dart';
import '../widget/home_page_app_bar.dart';
import '../widget/home_page_categories.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomePageAppBar(),
              VerticalSpace(18.h),
              HomePageCategories(
                onPressedAtSeeMore: () {},
                onPressedAddNewCategory: () {},
              ),
              HomePageAnimals(
                onPressedAtSeeMore: () {},
                onPressedAddNewCategory: () {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: ColorManager.kWhite2Color,
        selectedItemColor: ColorManager.kPrimaryColor,
        selectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: ColorManager.kPrimaryColor,
        ),
        unselectedItemColor: ColorManager.kGrey6Color,
        unselectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: ColorManager.kGrey6Color,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Animals'),
        ],
      ),
    );
  }
}
