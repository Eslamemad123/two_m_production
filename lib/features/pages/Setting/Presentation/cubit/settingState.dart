class SettingState {}
class SettingInitState extends SettingState{}

class SettingLoadingState extends SettingState{}

class SettingErrorState extends SettingState{
  final String error;
  SettingErrorState(this.error);
}

class SettingSuccessState extends SettingState{}