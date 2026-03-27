class SettingState {}
class SettingInitState extends SettingState{}

class SettingLoadingState extends SettingState{}

class SettingErrorState extends SettingState{
  final String error;
  SettingErrorState(this.error);
}

class SettingSuccessState extends SettingState{}
class SettingSuccessInjuctionState extends SettingState{}

class SettingProfileLoadedState extends SettingState {
  final String name;
  final String image;
  SettingProfileLoadedState({required this.name, required this.image});
}