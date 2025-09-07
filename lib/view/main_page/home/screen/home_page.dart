import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/spacing/vertical_space.dart';
import '../../widget/home_page_animals.dart';
import '../../widget/home_page_app_bar.dart';
import '../../widget/home_page_categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
    );
  }
}
