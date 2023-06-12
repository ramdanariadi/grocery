import 'package:bloc/bloc.dart';

enum ActiveMenu { home, product, cart, profile }

class CartState extends Bloc<int, int> {
  CartState(int initialState) : super(initialState) {
    on<int>((event, emit) {
      emit(event);
    });
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(
        "DataState current state ${change.currentState}, next state ${change.nextState}");
  }
}
