import 'package:animoo/controller/category_page_controller.dart';
import 'package:animoo/core/resources/assets_values_manager.dart';
import 'package:animoo/core/resources/colors_manager.dart';
import 'package:animoo/core/widgets/buttons/app_button.dart';
import 'package:animoo/core/widgets/spacing/horizontal_space.dart';
import 'package:animoo/core/widgets/spacing/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widget/category_form_field.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late CategoryPageController _categoryPageController;

  @override
  void initState() {
    super.initState();
    _categoryPageController = CategoryPageController(context);
  }
  @override
  void dispose() {
    _categoryPageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create New Category",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: ColorManager.kPrimaryColor,
                    fontFamily: FontsManager.otamaEpFontFamily,
                  ),
                ),
                VerticalSpace(12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 18.r,
                      backgroundImage: AssetImage(
                        "assets/image/background_splash_screen_undrer_12.png",
                      ),
                    ),
                    HorizontalSpace(6.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Salah Swidan",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorManager.kBlackColor,
                            fontFamily: FontsManager.originalSurferFontFamily,
                          ),
                        ),
                        VerticalSpace(4.h),
                        Container(
                          padding: EdgeInsets.all(5.r),
                          decoration: BoxDecoration(
                            color: ColorManager.kLightGreenColor.withOpacity(
                              0.10,
                            ),
                            borderRadius: BorderRadius.circular(32.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.public,
                                size: 10.sp,
                                color: ColorManager.kLightGreenColor,
                              ),
                              HorizontalSpace(3.w),
                              Text(
                                "Public",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorManager.kGreenColor,
                                  fontFamily:
                                      FontsManager.originalSurferFontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                VerticalSpace(22.h),
          
                CategoryFormField(
                  categoryFormKey: _categoryPageController.categoryFormKey,
                  categoryNameController: _categoryPageController.categoryNameController,
                 categoryDescriptionController: _categoryPageController.categoryDescriptionController, 
                 onChanged: _categoryPageController.onChanged,
                  categoryImageOutputStream: _categoryPageController.categoryFileImageOutputStream,
                   onTapSelectImage: _categoryPageController.onTapSelectImage,
                    selectImageStatus: _categoryPageController.selectImageStatus,
          
                ),
          
                VerticalSpace(31.h),
                AppButton(text: "Save", onTap: () {},
                buttonStatusOutputStream: _categoryPageController.saveButtonStatusOutputStream,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
