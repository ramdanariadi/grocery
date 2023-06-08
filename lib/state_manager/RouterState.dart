import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/custom_widget/ScaffoldBottomActionBar.dart';

class RotuerState extends Bloc<int, int> {
  RotuerState(int initialState) : super(initialState) {
    on<int>((event, emit) {
      emit(event);
    });
  }

  void go(
      {required BuildContext context,
      required String baseRoute,
      String? path,
      Object? extra}) {
    this.add(
        ScaffoldBottomActionBar.navbarItems.keys.toList().indexOf(baseRoute));
    GoRouter.of(context).go(
        baseRoute +
            (path == null
                ? ""
                : path.startsWith("/")
                    ? path
                    : "/" + path),
        extra: extra);
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
  }
}
