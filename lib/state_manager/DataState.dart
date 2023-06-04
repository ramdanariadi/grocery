import 'package:bloc/bloc.dart';

enum ActiveMenu { home, product, cart, profile }

class DataState<T> extends Bloc<T, T> {
  DataState(T initialState) : super(initialState) {
    on<T>((event, emit) {
      emit(event);
    });
  }

  @override
  void onChange(Change<T> change) {
    super.onChange(change);
    print(
        "DataState current state ${change.currentState}, next state ${change.nextState}");
  }
}
