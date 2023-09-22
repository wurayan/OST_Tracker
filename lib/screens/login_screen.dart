import 'package:flutter/material.dart';
import 'package:ost_tracker_og/cubit/usuario_cubit.dart';
import 'package:ost_tracker_og/decoration/theme.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final UsuarioCubit _usuarioCubit = UsuarioCubit();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: ColorTheme.blackberry,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: width * 0.8,
            height: height * 0.1,
            child: ElevatedButton(
              onPressed: () {
                _usuarioCubit.login();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorTheme.gojiberry,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset("assets/icons/google.png"),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    "LOGIN",
                    style:
                        CustomTextTheme.title.copyWith(color: ColorTheme.white),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
