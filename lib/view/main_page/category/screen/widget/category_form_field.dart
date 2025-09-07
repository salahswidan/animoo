import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/enums/select_image_status.dart';
import '../../../../../core/resources/assets_values_manager.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../../../../../core/widgets/custom_required_field.dart';
import '../../../../../core/widgets/custom_select_your_image_widget.dart';
import '../../../../../core/widgets/spacing/vertical_space.dart';

class CategoryFormField extends StatelessWidget {
  const CategoryFormField({
    super.key,
    required this.categoryNameController,
    required this.categoryDescriptionController,
    required this.onChanged,
    required this.categoryImageOutputStream,
    required this.onTapSelectImage,
    required this.selectImageStatus,
    required this.categoryFormKey,
  });

  final TextEditingController categoryNameController;
  final TextEditingController categoryDescriptionController;
  final void Function(String value) onChanged;
  final Stream<File?> categoryImageOutputStream;
  final void Function(FormFieldState<File>) onTapSelectImage;
  final SelectImageStatus selectImageStatus;
  final GlobalKey<FormState> categoryFormKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: categoryFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRequiredField(
            controller: categoryNameController,
            title: "Category Name",
            hintText: "Enter category name",
            keyboardType: TextInputType.text,
            onChanged: onChanged,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter category name';
              } else if (value.length < 3 || value.length > 20) {
                return 'Category name must be between 3 and 20 characters';
              }
              return null;
            },
          ),
          VerticalSpace(12.h),
          CustomRequiredField(
            onChanged: onChanged,
            maxLines: 3,
            controller: categoryDescriptionController,
            title: "Category Description",
            hintText: "Enter category description",
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter category description';
              } else if (value.length < 20 || value.length > 200) {
                return 'Category description must be between 20 and 200 characters';
              }
              return null;
            },
          ),
          VerticalSpace(12.h),
          Text(
            "Select image category",
            style: TextStyle(
              fontSize: 16.sp,
              color: ColorManager.kGrey6Color,
              fontFamily: FontsManager.poppinsFontFamily,
            ),
          ),
          VerticalSpace(4.h),
          StreamBuilder<File?>(
            stream: categoryImageOutputStream,
            initialData: null,
            builder:
                (context, snapshot) => CustomSelectImageWidget(
                  file: snapshot.data,
                  onTapAtSelectImage: onTapSelectImage,
                  selectImageStatus: SelectImageStatus.noImageSelected,
                ),
          ),
        ],
      ),
    );
  }
}
