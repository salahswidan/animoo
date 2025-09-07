import 'dart:async';
import 'dart:io';

import 'package:animoo/core/enums/select_image_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../core/enums/button_states_enum.dart';
import '../core/enums/screen_status_state.dart';
import '../core/functions/image_picker_service.dart';
import '../core/functions/show_select_image_model_bottom_sheet.dart';

class CategoryPageController {
  File? fileImage;
  SelectImageStatus selectImageStatus = SelectImageStatus.normal;
  ButtonStatesEnum saveButtonStatus = ButtonStatesEnum.disabled;
  ScreenStatusState screenState = ScreenStatusState.initial;

  final GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();
  late TextEditingController categoryNameController;
  late TextEditingController categoryDescriptionController;

  late Stream<File?> categoryFileImageOutputStream;
  late Sink<File?> categoryFileImageInput;
  late StreamController<File?> categoryFileImageController;

  late Stream<ButtonStatesEnum?> saveButtonStatusOutputStream;
  late Sink<ButtonStatesEnum?> saveButtonStatusInput;
  late StreamController<ButtonStatesEnum?> saveButtonStatusController;

  late Stream<bool> loadingScreenStatusOutputStream;
  late StreamController<bool> loadingScreenStatusController;
  late Sink<bool> loadingScreenStatusInput;
  final BuildContext context;

  CategoryPageController(this.context) {
    init();
  }

  void init() {
    initControllers();
    initStreams();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      changeSaveButtonStatus(ButtonStatesEnum.disabled);
    });
  }

  void changeSaveButtonStatus(ButtonStatesEnum status) {
    saveButtonStatus = status;
    saveButtonStatusInput.add(status);
  }

  void initControllers() {
    categoryNameController = TextEditingController();
    categoryDescriptionController = TextEditingController();
  }

  void initStreams() {
    categoryFileImageController = StreamController<File?>();
    categoryFileImageOutputStream =
        categoryFileImageController.stream.asBroadcastStream();
    categoryFileImageInput = categoryFileImageController.sink;

    saveButtonStatusController = StreamController<ButtonStatesEnum?>();
    saveButtonStatusOutputStream =
        saveButtonStatusController.stream.asBroadcastStream();
    saveButtonStatusInput = saveButtonStatusController.sink;

    loadingScreenStatusController = StreamController<bool>();
    loadingScreenStatusOutputStream =
        loadingScreenStatusController.stream.asBroadcastStream();
    loadingScreenStatusInput = loadingScreenStatusController.sink;
  }

  void dispose() {
    disposeControllers();
    disposeStreams();
  }

  void disposeControllers() {
    categoryNameController.dispose();
    categoryDescriptionController.dispose();
  }

  void disposeStreams() {
    categoryFileImageController.close();
    categoryFileImageInput.close();

    saveButtonStatusController.close();
    saveButtonStatusInput.close();

    loadingScreenStatusController.close();
    loadingScreenStatusInput.close();
  }

  void onChanged(String value) {
    checkValidateForm();
  }

  void checkValidateForm() {
    if (categoryFormKey.currentState!.validate()) {
      changeSaveButtonStatus(ButtonStatesEnum.enabled);
    } else {
      changeSaveButtonStatus(ButtonStatesEnum.disabled);
    }
  }

  void _onTapAtCamera() async {
    fileImage = await ImagePickerService.pickImage(ImageSource.camera);
    categoryFileImageInput.add(fileImage);
    if (context.mounted) Navigator.pop(context);
  }

  void _onTapAtGallery() async {
    fileImage = await ImagePickerService.pickImage(ImageSource.gallery);
    categoryFileImageInput.add(fileImage);
    if (context.mounted) Navigator.pop(context);
  }

  void onTapSelectImage(FormFieldState<File> state) async {
    //?chow model bottom sheet
    await showSelectImageModelBottomSheet(
      context,
      
        _onTapAtCamera
      ,

      
        _onTapAtGallery
      
    );

    //?check if image is selected
    if (fileImage == null) {
      selectImageStatus = SelectImageStatus.noImageSelected;
    } else {
      selectImageStatus = SelectImageStatus.imageSelected;
      state.didChange(fileImage);
      checkValidateForm();
    }
  }
}
