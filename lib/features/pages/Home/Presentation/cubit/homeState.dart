class HomeState {}
class HomeInitState extends HomeState{}

class HomeLoadingState extends HomeState{}

class HomeErrorState extends HomeState{
  final String error;
  HomeErrorState(this.error);
}

class HomeSuccessState extends HomeState{}