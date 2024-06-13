import 'dart:developer';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/firebase_options.dart';
import 'package:sutra_ecommerce/routes/route.dart';
import 'package:sutra_ecommerce/screens/tab_screen/TestScreen.dart';
import 'package:sutra_ecommerce/utils/api_constants.dart';
import 'package:sutra_ecommerce/utils/network_dio.dart';

import './screens/landing_screen.dart';
import 'hive_models/Orders/create_order.dart';
import 'utils/custom_theme.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );
  await Hive.initFlutter();
  //Hive.registerAdapter(CatModelAdapter());
  Hive.registerAdapter(CreateOrderModelAdapter());
  box = await Hive.openBox('Box');
  await Hive.openBox('otpBox');


  if (!kIsWeb) {
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }
  }

  log(box.toString());

  if (kIsWeb) {
    NetworkDioHttp.setDynamicHeaderWeb(endPoint: ApiAppConstants.apiEndPoint);
  } else {
    NetworkDioHttp.setDynamicHeader(endPoint: ApiAppConstants.apiEndPoint);
  }
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  // Get.put(AddToCartController());
  // Get.put(MyCartController());
 
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    analytics.setAnalyticsCollectionEnabled(true);
    // flutterLocalNotificationsPlugin.initialize(
    //     const InitializationSettings(
    //       android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    //       iOS: DarwinInitializationSettings(),
    //     ), onDidReceiveNotificationResponse: (NotificationResponse load) async {
    //   try {
    //     if (load.payload!.isNotEmpty) {
    //       log(jsonDecode(load.payload!));
    //     }
    //   } catch (_) {
    //     log(_.toString());
    //   }
    //   return;
    // });
    // appInfo();
    // Future.delayed(const Duration(seconds: 2));
    // FlutterNativeSplash.remove();
  }

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final customTheme = CustomTheme(constraints);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ecommerce',
          navigatorObservers: [ChuckerFlutter.navigatorObserver],
          theme: ThemeData(
              //primarySwatch: Colors.green,
              useMaterial3: false,
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
              bottomSheetTheme: customTheme.bottomSheetTheme()),
          getPages: pages,
          initialBinding: StoreBinding(),
          home: isLoggedIn == true ? const TestScreen() : const LandingScreen(),
          // home: TestScreen(),
          //  const LandingScreen(),
        );
      },
    );
  }
}
