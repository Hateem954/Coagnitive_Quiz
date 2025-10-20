import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/age_provider.dart';
import 'package:quiz/provider/basicinfo_provider.dart';
import 'package:quiz/provider/gender_provider.dart';
import 'package:quiz/provider/guardian_profile_provider.dart';
import 'package:quiz/Controller/register_controller.dart';
import 'package:quiz/provider/image_provider.dart';
import 'package:quiz/provider/login_provider.dart';
import 'package:quiz/provider/otp_provider.dart';
import 'package:quiz/provider/profile_provider.dart';
import 'package:quiz/provider/profile_update_provider.dart';
import 'package:quiz/provider/subvideo_provider.dart';
import 'package:quiz/provider/video_provider.dart';
import 'package:quiz/splash_screen.dart';
import 'package:quiz/views/Quiz_questionscreen.dart';
import 'package:quiz/views/basic_info.dart';
import 'package:quiz/views/guardian_screen.dart';
import 'package:quiz/views/map_screen.dart';
import 'package:quiz/views/video_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => VideoProvider()),
        ChangeNotifierProvider(create: (_) => SubVideoProvider()),
        ChangeNotifierProvider(create: (_) => GuardianProvider()),
        ChangeNotifierProvider(create: (_) => BasicInfoProvider()),
        ChangeNotifierProvider(create: (_) => GenderProvider()),
        ChangeNotifierProvider(create: (_) => ProfileImageProvider()),
        ChangeNotifierProvider(create: (_) => AgeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ProfileUpdateProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // base design size
      minTextAdapt: true, // important for text scaling
      splitScreenMode: true, // allows multi-window support
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // home: SplashScreen(),
          home: SplashScreen(),
          // home: VideoScreen(hashid: "a9ngZBglWw"),
        );
        // );
      },
    );
  }
}
