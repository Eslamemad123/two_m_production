import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:two_m_production/core/GetIt/gi.dart';
import 'package:two_m_production/core/extentions/show_dialoges.dart';
import 'package:two_m_production/core/routes/navigation.dart';
import 'package:two_m_production/core/extentions/image_upload.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/Setting/Domain/UseCase/addProductUseCase.dart';
import 'package:two_m_production/features/pages/Setting/Domain/UseCase/editProfileUseCase.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingState.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitState());
  final List<XFile> selectedMedia = [];

  final Editprofileusecase editProfileUsecase = gi<Editprofileusecase>();
  final AddProductUseCase addProductUsecase = gi<AddProductUseCase>();
  var name = TextEditingController();
  String? patImage = FirebaseAuth.instance.currentUser?.photoURL ?? '';
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  editProfile(String newName, String pathImage, BuildContext context) async {
    emit(SettingLoadingState());
    isLoading = true;

    String finalImageUrl = pathImage;

    // Check if the pathImage is a local path (doesn't start with http/https) and is not empty
    if (pathImage.isNotEmpty && !pathImage.startsWith('http')) {
      final File imageFile = File(pathImage);

      final url = await uploadImageToCloudinary(
        imageFile,
        "dislsl3sa",
        "se77ty",
        context,
      );

      if (url != null) {
        finalImageUrl = url;
      } else {
        emit(SettingErrorState('Failed to upload image.'));
        isLoading = false;
        return;
      }
    }

    var response = await editProfileUsecase.call(newName, finalImageUrl);
    response.fold(
      (Failure) {
        emit(SettingErrorState(Failure.message));
        isLoading = false;
      },
      (bool val) {
        emit(SettingSuccessState());

        Future.delayed(Duration(seconds: 2), () {
          isLoading = false;
          Pop(context);
        });
      },
    );
  }

  addProduct(BuildContext context) async {
    emit(SettingLoadingState());
    ProductModel product = ProductModel(
      name: nameController.text,
      description: descriptionController.text,
      section: 'Acrylic Sheets',
      size: 3,
      stock: int.parse(stockController.text),
      price: int.parse(priceController.text),
      id: '',
      state: '',
      note: '',
      date: DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
      code: codeController.text,
      injectionMolding: '1',
      subName: codeController.text,
      imagePath: selectedMedia,
    );
    var response = await addProductUsecase.call(product);
    response.fold(
      (Failure) {
        emit(SettingErrorState(Failure.message));
        showMyDialog(
          context,
          'حدث خطا اثناء اضافة المنتج',
          type: DialogType.error,
        );
      },
      (bool val) {
        emit(SettingSuccessState());
        showMyDialog(
          context,
          'تم اضافة المنتج بنجاح',
          type: DialogType.success,
        );
      },
    );
  }
}
