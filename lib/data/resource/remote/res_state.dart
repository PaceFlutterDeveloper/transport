class DataError<T> extends ResDataState<T> {
  const DataError(String error) : super(error: error);
}

class DataFailed<T> extends ResDataState<T> {
  const DataFailed(String error) : super(error: error);
}

class DataLoaded<T> extends ResDataState<T> {
  const DataLoaded(String error) : super(error: error);
}

class DataLoading<T> extends ResDataState<T> {
  const DataLoading(String error) : super(error: error);
}

class DataNoData<T> extends ResDataState<T> {
  const DataNoData(String error) : super(error: error);
}

class DataUninitialized<T> extends ResDataState<T> {
  const DataUninitialized();
}

abstract class ResDataState<T> {
  final String? error;

  const ResDataState({this.error});
}
