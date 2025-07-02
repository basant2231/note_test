import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_test/firebase_options.dart';
import 'app/controllers/auth_controller.dart';
import 'app/controllers/note_controller.dart';
import 'app/views/auth/login_view.dart';
import 'app/views/home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  Get.put(NoteController());
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (BuildContext context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Note App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Obx(() {
        final user = AuthController.to.user;
        if (user == null) {
          return LoginView();
        } else {
          return HomeView();
        }
      }),
    );
  }
}
