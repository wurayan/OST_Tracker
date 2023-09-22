import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ost_tracker_og/decoration/theme.dart';

class InitialLoadingScreen extends StatelessWidget {
  const InitialLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.blackberry,
      body: SafeArea(
        child: Center(
          child: SpinKitWave(
            color: ColorTheme.gojiberry,
          ),
        ),
      ),
    );
  }
}