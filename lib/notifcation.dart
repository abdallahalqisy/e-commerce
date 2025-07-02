import 'package:firebase_messaging/firebase_messaging.dart';

class FcmApi {
  // Your FireApi implementation goes here
  final firebaseMessaging = FirebaseMessaging.instance;
  intNotifactions() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    final fcmToken = await firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundFcm);
  }
}

Future<void> handleBackgroundFcm(RemoteMessage message) async {
  print('Handling a background message: ${message.messageType}');
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // Handle background message
// }
