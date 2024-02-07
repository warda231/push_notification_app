import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

Future<void> handlebackgroundmessage(RemoteMessage message) async{
  print('title: ${message.notification?.title}');
    print('body: ${message.notification?.body}');
    


}


class FirebaseApi {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

    FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> init() async {
        await initNotifications();

    await Notification();
  }

  Future<void> initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo'); // replace 'logo' with your icon name
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async{

  }
    );
  }



 Future<void> saveTokenToFirestore(String token) async {
    try {
      
      await _firestore.collection('tokens').add({
        'token': token,
      });
      print('Token saved to Firestore successfully');
    } catch (e) {
      print('Error saving token to Firestore: $e');
    }
  }



  Future<void> Notification() async {
    await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken(
      // server key used for web push notifications.
      vapidKey: "BExAU4hfaUUcpWPH9P8t4VVAMByv-A2bbjH23y4GSO6g-s_wPBr8jrCTtahH7Qrxvtv_W_r5Pmij2kMyCMk9_pE",
    );
    print('Token#: $token');
  saveTokenToFirestore(token!);

    FirebaseMessaging.onBackgroundMessage(handlebackgroundmessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground messages on both mobile and web
      print('Handling foreground message: $message');
            _displayNotification(message);

      _displayWebNotification(message);
    });
  }

  Future<void> sendNotification(String token, String title, String body) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final headers = {
      'Content-Type': 'application/json',
      //server key
      'Authorization': 'key=AAAAtf3ywLo:APA91bFiouT4hmK-XvHe6nkjUWSuoN2vBHHw-V1uUFcA-rj65GrGApDMOc4hMxphjf2sJeNmVyE1hHbao97q8hsgHi2kaE-_m9JGFXBGFZKM0VncJ_tguZe8PuM5i4Y_k12Qi9ypTAS-',
    };

    final payload = {
      'notification': {
        'title': title,
        'body': body,
      },
      'to': token,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(payload),
    );
    print(payload);

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
    }
  }

  Future<void> _displayNotification(RemoteMessage message) async {
    // Display notification on mobile
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? 'Notification',
      message.notification?.body ?? 'Body',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }


Future<void> _displayWebNotification(RemoteMessage message) async {
  // Handle displaying web notifications using the browser's native API
  if (html.Notification.supported) {
    if (await html.Notification.requestPermission() == 'granted') {
      html.Notification(message.notification?.title ?? 'Notification',
          body: message.notification?.body ?? 'Body');
    }
  }
}


}
 