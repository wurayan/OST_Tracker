import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/cubit/usuario_cubit.dart';
import 'package:ost_tracker_og/screens/home_screen.dart';
import 'package:ost_tracker_og/screens/login_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final UsuarioCubit _usuarioCubit = UsuarioCubit();

  @override
  void initState() {
    // _usuarioCubit.login();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsuarioCubit, UsuarioStates>(
      bloc: _usuarioCubit,
      builder: (context, state) {
        if (state is UsuarioLogin) {
          print("USER on");
          return const HomeScreen();
        } else if (state is UsuarioError) {
          // TODO criar o error logger
          return LoginScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
