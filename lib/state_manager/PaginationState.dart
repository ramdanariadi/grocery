import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginationState extends Bloc<List<dynamic>, List<dynamic>> {
  List<dynamic> data;
  int pageSize;
  int pageIndex;
  bool _isLoading = false;

  PaginationState({required this.data, this.pageIndex = 0, this.pageSize = 10})
      : super(data) {
    on<List<dynamic>>((event, emit) {
      emit(List.of(this.data));
      debugPrint(
          "scroll controller fetch product emited " + event.length.toString());
    });
  }

  void setIsLoading(bool isLoading, Widget? widget) {
    this._isLoading = isLoading;
    if (this._isLoading) {
      this.data.add(widget);
      this.add(this.data);
    } else {
      this.data.removeLast();
      this.add(this.data);
    }
  }

  bool isLoading() {
    return this._isLoading;
  }

  void refresh(
      {required List<dynamic> data,
      int? pageSize,
      int? pageIndex,
      bool addNewDataAtLast = true}) {
    if (null != pageIndex) {
      this.pageIndex = pageIndex;
    }

    if (null != pageSize) {
      this.pageSize = pageSize;
    }

    if (this._isLoading) {
      this.data.removeLast();
      this._isLoading = false;
    }

    // this.data.addAll(data);
    this.data.insertAll(addNewDataAtLast ? this.data.length : 0, data);
    this.add(this.data);
  }
}
