abstract class CountryDetailScreenState {}

class InitState extends CountryDetailScreenState {
  InitState();
}

class FailureState extends CountryDetailScreenState {
  String? error;

  FailureState({this.error});
}

class LoadingState extends CountryDetailScreenState {
  LoadingState();
}

class SuccessfulState extends CountryDetailScreenState {
  SuccessfulState();
}
