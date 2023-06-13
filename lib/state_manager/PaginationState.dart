import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginationState extends Bloc<List<dynamic>, List<dynamic>> {
  List<dynamic> data;
  int pageSize;
  int pageIndex;

  PaginationState({required this.data, this.pageIndex = 0, this.pageSize = 10})
      : super(data) {
    on<List<dynamic>>((event, emit) {
      this.data.addAll(event);
      emit(List.of(this.data));
      debugPrint(
          "scroll controller fetch product emited " + event.length.toString());
    });
  }

  void refresh({required List<dynamic> data, int? pageSize, int? pageIndex}) {
    if (null != pageIndex) {
      this.pageIndex = pageIndex;
    }

    if (null != pageSize) {
      this.pageSize = pageSize;
    }

    this.add(data);
  }
}
