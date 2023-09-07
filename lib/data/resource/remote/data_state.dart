enum DataState {
  Uninitialized,
  Loading,
  Loaded,
  Error,
  NoData,
}

class ResDataState {
  final DataState dataState;
  final String? message;

  ResDataState({this.message, required this.dataState});
}
