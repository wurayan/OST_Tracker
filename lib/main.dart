import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/firebase_options.dart';
import 'package:ost_tracker_og/screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: white, home: const Wrapper());
  }
}
