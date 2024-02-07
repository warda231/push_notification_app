import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_app/Pages/HomePage.dart';
import 'package:push_notification_app/Service/NotificationService.dart';
import 'package:push_notification_app/Service/PushNotification.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    sound: true,
    alert: true,
    badge: true,
  );
  
  await FirebaseApi().init();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
        NotificationService().initNotification();

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
