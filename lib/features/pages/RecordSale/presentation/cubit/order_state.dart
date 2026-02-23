class OrderState {}
class OrderInitState extends OrderState{}

class OrderLoadingState extends OrderState{}

class OrderErrorState extends OrderState{
  final String error;
  OrderErrorState(this.error);
}

class OrderSuccessState extends OrderState{}