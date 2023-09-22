import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/cubit/generic_state.dart';

class Okay extends GenericState {}

class Error extends GenericState {
  final String msg;
  Error(this.msg);
}

class ErrorCubit extends Cubit<GenericState> {
  ErrorCubit() : super(Okay());

  void showError(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("DENTRO DO CUBIT")));
    emit(Error(msg));
  }
}
