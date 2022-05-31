abstract class HomeScreenState {}

class InitState extends HomeScreenState {
  InitState();
}

class FailureState extends HomeScreenState {
  String? error;

  FailureState({this.error});
}

class LoadingState extends HomeScreenState {
  LoadingState();
}

class SuccessfulState extends HomeScreenState {
  SuccessfulState();
}
