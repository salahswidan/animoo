import 'package:animoo/controller/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/spacing/vertical_space.dart';
import '../../widget/home_page_animals.dart';
import '../../widget/home_page_app_bar.dart';
import '../../widget/home_page_categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController _homePageController;

  @override
  void initState() {
    super.initState();
    _homePageController = HomePageController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomePageAppBar(),
            VerticalSpace(18.h),
            HomePageCategories(
              onPressedAtSeeMore: () {
                _homePageController.onPressedAtSeeMore(context);
              },
              onPressedAddNewCategory: () {},
            ),
            HomePageAnimals(
              onPressedAtSeeMore: () {},
              onPressedAddNewCategory: () {},
            ),
          ],
        ),
      ),
    );
  }
}
