
// ignore_for_file: prefer_const_constructors

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  final FlutterLocalNotificationsPlugin plugin=FlutterLocalNotificationsPlugin();

Future<void> initNotification()async{
  AndroidInitializationSettings settings=AndroidInitializationSettings('logo');

  var intitialization=InitializationSettings(android: settings);

  await plugin.initialize(intitialization,
  onDidReceiveNotificationResponse: (NotificationResponse response) async{

  });
}

notificationDetails(){
  return NotificationDetails(
    android: AndroidNotificationDetails('channelId', 'channelName',
    importance: Importance.max,
     priority: Priority.high,
            ticker: 'ticker')
  );
}

Future showNotification({int id=0, String? title,String? body,String? payload})async{
  return plugin.show(id, title, body, await notificationDetails());
}

}