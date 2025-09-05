import 'package:animoo/core/widgets/spacing/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/home_page_app_bar.dart';
import '../widget/home_page_categories.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
              Text("data"),
            ],
          ),
        ),
      ),
    );
  }
}
