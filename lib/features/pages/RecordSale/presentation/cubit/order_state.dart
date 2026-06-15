import 'package:two_m_production/features/pages/RecordSale/Data/model/customer_model.dart';

class OrderState {}

class OrderInitState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderErrorState extends OrderState {
  final String error;
  OrderErrorState(this.error);
}

class OrderSuccessState extends OrderState {}

class OrderSearchLoadingState extends OrderState {}

class OrderSearchSuccessState extends OrderState {
  final List<CustomerModel> orders;
  OrderSearchSuccessState(this.orders);
}
