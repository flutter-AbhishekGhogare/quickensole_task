import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:quickensol_task/controller/signincontroller.dart';
import 'package:quickensol_task/firebase_options.dart';
import 'package:quickensol_task/view/signinpage.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initController();
    return const GetMaterialApp(
      title: 'Quickensol task',
      home: SignInScreen(),
    );
  }
}

void initController() {
  Get.put(SignUpController());
  Get.put(SignInController());
  Get.put(UserController());
}
