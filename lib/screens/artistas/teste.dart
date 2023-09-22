import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/components/appbar/appbar_custom.dart';
import 'package:ost_tracker_og/cubit/error_cubit.dart';
import 'package:ost_tracker_og/cubit/generic_state.dart';

class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  final ErrorCubit _cubit = ErrorCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarCustom(title: "rteste", activeSearch: false),
        body: BlocConsumer<ErrorCubit, GenericState>(
          bloc: _cubit,
          listenWhen: (previous, current) => current is Error,
          listener: (context, state) {
          },
          builder: (context, state) {
            return SafeArea(
                child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      _cubit.showError(context, "");
                    },
                    child: SizedBox(
                      height: 50,
                      width: 50,
                    ))
              ],
            ));
          },
        ));
  }
}
