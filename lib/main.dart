import 'dart:developer';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/routes/route.dart';
import 'package:sutra_ecommerce/screens/tab_screen/tab_screen.dart';
import 'package:sutra_ecommerce/utils/api_constants.dart';
import 'package:sutra_ecommerce/utils/network_dio.dart';

import './models/item.dart';
import './screens/landing_screen.dart';
import 'utils/custom_theme.dart';

void main() async {
  await Hive.initFlutter();
  box = await Hive.openBox('Box');

  log(box.toString());

  if (kIsWeb) {
    NetworkDioHttp.setDynamicHeaderWeb(endPoint: ApiAppConstants.apiEndPoint);
  } else {
    NetworkDioHttp.setDynamicHeader(endPoint: ApiAppConstants.apiEndPoint);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = box!.get('login') ?? false;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Brightness.dark, // Change status bar icons color (light or dark)
      ),
    );
    return ChangeNotifierProvider(
      create: (context) => Items(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final customTheme = CustomTheme(constraints);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ecommerce',
            navigatorObservers: [ChuckerFlutter.navigatorObserver],
            theme: ThemeData(
              //primarySwatch: Colors.green,
              primarySwatch: const MaterialColor(
                0xFF71C4ED,
                <int, Color>{
                  50: Color(0xFFB3E0F8),
                  100: Color(0xFF81CAEB),
                  200: Color(0xFF4FB3DE),
                  300: Color(0xFF1D9CCF),
                  400: Color(0xFF007BBF),
                  500: Color(0xFF0069A5),
                  600: Color(0xFF00588A),
                  700: Color(0xFF004770),
                  800: Color(0xFF003655),
                  900: Color(0xFF00253C),
                },
              ),
              textTheme: customTheme.nunito(),
              elevatedButtonTheme: customTheme.elevatedButtonTheme(),
              outlinedButtonTheme: customTheme.outlinedButtonTheme(),
              textButtonTheme: customTheme.textButtonTheme(),
              dividerTheme: customTheme.dividerTheme(),
            ),
            getPages: pages ,
            initialBinding: StoreBinding(),
            home:
                isLoggedIn == false ? const TabScreen() : const LandingScreen(),
          );
        },
      ),
    );
  }
}
