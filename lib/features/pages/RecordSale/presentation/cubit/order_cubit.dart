import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_m_production/core/GetIt/gi.dart';
import 'package:two_m_production/core/extentions/show_dialoges.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';
import 'package:two_m_production/features/pages/RecordSale/Domain/Usecase/addOrder_UseCse.dart';
import 'package:two_m_production/features/pages/RecordSale/presentation/cubit/order_state.dart';
import 'package:two_m_production/features/pages/oreder/Domain/Usecase/getOrdersUseCse.dart';
import 'package:two_m_production/features/pages/oreder/Domain/Usecase/searchOrderUseCse.dart';
import 'package:two_m_production/features/pages/oreder/Domain/Usecase/filterOrderUseCase.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitState());
  final AddOrderUseCase homeSection = gi<AddOrderUseCase>();
  final getOrdersUseCase getOrder = gi<getOrdersUseCase>();
  final SearchOrdersUseCase searchOrderUseCase = gi<SearchOrdersUseCase>();
  final FilterOrdersUseCase filterOrderUseCase = gi<FilterOrdersUseCase>();
  bool vodafonCash = false;
  bool inDrive = false;
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  List<OrderModel> orders = [];
  void addOrder(Map<String, int> orderSizes, BuildContext context) async {
    final order = OrderModel(
      name: nameController.text,
      price: double.parse(priceController.text),
      Phone: phoneController.text,
      orderId: '10',
      date: dateController.text,
      sizes: orderSizes,
      inDrive: inDrive,
      vodafoneCash: vodafonCash,
    );
    emit(OrderLoadingState());
    var response = await homeSection.call(order);
    response.fold(
      (Failure) {
        emit(OrderErrorState(Failure.message));
      },
      (bool b) {
        showMyDialog(
          context,
          type: DialogType.success,
          'The order was added successfully.',
        );
        emit(OrderSuccessState());

        nameController.clear();
        priceController.clear();
        dateController.clear();
        phoneController.clear();
        formKey.currentState?.reset();
      },
    );
  }

  void getOrders() async {
    emit(OrderLoadingState());

    final response = await getOrder.call();

    response.fold(
      (failure) {
        emit(OrderErrorState(failure.message));
      },
      (List<OrderModel> data) {
        orders = data;
        emit(OrderSuccessState());
      },
    );
  }

  void searchOrders(String query) async {
    emit(OrderSearchLoadingState());

    final response = await searchOrderUseCase.call(query);

    response.fold(
      (failure) {
        emit(OrderErrorState(failure.message));
      },
      (List<OrderModel> data) {
        emit(OrderSearchSuccessState(data));
      },
    );
  }

  void filterOrdersByDate(String date) async {
    emit(OrderSearchLoadingState());

    final response = await filterOrderUseCase.call(date);

    response.fold(
      (failure) {
        emit(OrderErrorState(failure.message));
      },
      (List<OrderModel> data) {
        emit(OrderSearchSuccessState(data));
      },
    );
  }
}
