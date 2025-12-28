import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_m_production/core/GetIt/gi.dart';
import 'package:two_m_production/core/routes/navigation.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';
import 'package:two_m_production/features/pages/Setting/Domain/UseCase/editProfileUseCase.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingState.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitState());
  final Editprofileusecase editProfileUsecase = gi<Editprofileusecase>();
  var name = TextEditingController();
  String? patImage = FirebaseAuth.instance.currentUser?.photoURL ?? '';
  bool isLoading = false;
  editProfile(String name, String pathImage, BuildContext context) async {
    emit(SettingLoadingState());
    isLoading = true;
    var response = await editProfileUsecase.call(name, pathImage);
    response.fold(
      (Failure) {
        emit(SettingErrorState(Failure.message));
        isLoading = false;
      },
      (bool) {
        emit(SettingSuccessState());
       
        Future.delayed(Duration(seconds: 2), () {
          isLoading = false;
          Pop(context);
        });
      },
    );
  }
}
