// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:push_notification_app/Service/PushNotification.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 185, 215, 240),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            'Push Notification!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Notification App',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {

                
                // Obtain FCM token of the target device
                String targetDeviceToken = "fAKvEUC0JPJzo0ZLxAGoKb:APA91bEjoQE8_aJ9RHSmEmB14twU9HIqTUQwMwMRpQM8XRExKAvoOfnDFDZvz3O6N1HKqOwN-yCoKU19WUxwNnexC-mcMnyDhTI3Nmz5OI2fSJQLZ0c36A1vjDXeQ7A7X76Ft0BUlf8Q";

                // Define title and body for the notification
                String title = 'New notification!';
                String body = 'Details!';

                // Send the notification
                await FirebaseApi().sendNotification(
                  targetDeviceToken,
                  title,
                  body,
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              ),
              child: Text(
                'Send Notification',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
