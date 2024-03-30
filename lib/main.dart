import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yandex_location/screens/splash_screen/splash_screen.dart';
import 'package:yandex_location/services/local_notification.dart';
import 'package:yandex_location/view_models/adress_view_model.dart';
import 'package:yandex_location/view_models/location_view_model.dart';
import 'package:yandex_location/view_models/locations_view_model.dart';
import 'package:yandex_location/view_models/map_view_model.dart';
import 'firebase_options.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(
      "BACKGROUND MODE DA PUSH NOTIFICATION KELDI:${message.notification!.title}");
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureLocalTimeZone();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.subscribeToTopic("news");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  LocalNotificationService.localNotificationService.init(navigatorKey);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapsViewModel()),
        ChangeNotifierProvider(create: (_) => AddressesViewModel()),
        ChangeNotifierProvider(create: (_) => LocationsViewModel()),
        ChangeNotifierProvider(create: (_) => LocationViewModel()),
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
      designSize: const Size(375, 812),
      builder: (context, child) {
        ScreenUtil.init(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}