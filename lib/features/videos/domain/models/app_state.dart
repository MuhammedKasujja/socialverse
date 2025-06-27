sealed class AppState<T> {}

class Loading extends AppState {}

class Loaded<T> extends AppState<T> {
  final T data;
  Loaded(this.data);
}

class Error extends AppState {
  final String message;
  Error(this.message);
}
