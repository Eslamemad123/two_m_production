import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_m_production/core/GetIt/gi.dart';
import 'package:two_m_production/core/extentions/show_dialoges.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';
import 'package:two_m_production/features/pages/RecordSale/Domain/Usecase/addOrder_UseCse.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/cubit/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitState());
  final AddOrderUseCase homeSection = gi<AddOrderUseCase>();
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  void addOrder(OrderModel order, BuildContext context) async {
    emit(OrderLoadingState());
    var response = await homeSection.call(order);
    response.fold(
      (Failure) {
        emit(OrderErrorState(Failure.message));
      },
      (bool b) {
        showMyDialog(context, type: DialogType.success, 'Error');
        emit(OrderSuccessState());
      },
    );
  }
}
