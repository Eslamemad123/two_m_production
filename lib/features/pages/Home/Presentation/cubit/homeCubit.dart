import 'dart:async';

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
  StreamSubscription? _homeSubscription;

  var sizePriority = {'Middle': 0, 'Small Red': 1, 'Large': 2, 'X Large': 3};

  void getHomeSection(String? section) {
    emit(HomeLoadingState());
    if (section != null) categoryHomeKet = section;
    _homeSubscription?.cancel();

    _homeSubscription = homeSection.call(categoryHomeKet ?? '2M Covers').listen(
      (response) {
        response.fold(
          (failure) {
            emit(HomeErrorState(failure.message));
          },
          (List<ProductModel> p) {
            p.sort((a, b) {
              final aSize = (a.name).trim();
              final bSize = (b.name).trim();

              final aPriority = sizePriority[aSize] ?? 999;
              final bPriority = sizePriority[bSize] ?? 999;

              return aPriority.compareTo(bPriority);
            });

            products = List.from(p);

            emit(HomeSuccessState());
          },
        );
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
        showMyDialog(context, type: DialogType.error, 'error');
        emit(HomeErrorState(Failure.message));
      },
      (bool b) {
        Pop(context);
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
