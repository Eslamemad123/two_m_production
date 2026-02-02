import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_m_production/core/GetIt/gi.dart';
import 'package:two_m_production/core/extentions/show_dialoges.dart';
import 'package:two_m_production/core/routes/navigation.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/Home/Domain/UseCase/addProductStockUseCase.dart';
import 'package:two_m_production/features/pages/Home/Domain/UseCase/getHomeSectionUseCase.dart';
import 'package:two_m_production/features/pages/Home/Presentation/cubit/homeState.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());
  final GetHomeSectionUseCase homeSection = gi<GetHomeSectionUseCase>();
  final AddProductStock addProduct = gi<AddProductStock>();
  String? categoryHomeKet;
  int selectedIndex = 0;
  final TextEditingController addProductController = TextEditingController(
    text: '0',
  );
  TextEditingController? dateController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  List<ProductModel> products = [];

  getHomeSection() async {
    emit(HomeLoadingState());
    var response = await homeSection.call(categoryHomeKet ?? '2M Covers');
    response.fold(
      (Failure) {
        emit(HomeErrorState(Failure.message));
      },
      (List<ProductModel> p) {
        products = p;
        emit(HomeSuccessState());
      },
    );
  }

  addProductStock(BuildContext context, String id) async {
    emit(HomeLoadingState());
    String dateToSend = dateController!.text.trim().isEmpty
        ? DateFormat('yyyy-MM-dd').format(DateTime.now())
        : dateController!.text;
    var response = await addProduct.call(
      int.parse(addProductController.text),
      id,
      dateToSend,
      noteController.text,
    );
    response.fold(
      (Failure) {
        emit(HomeErrorState(Failure.message));
      },
      (bool b) {
        Pop(context);
        showMyDialog(
          context,
          type: DialogType.success,
          'Sucsecc Add Product count ${int.parse(addProductController.text)} in stock',
        );
        emit(HomeSuccessState());
      },
    );
  }
}
