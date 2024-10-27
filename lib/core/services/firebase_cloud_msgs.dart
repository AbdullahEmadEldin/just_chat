import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/modules/messages/data/models/message_model.dart';

class FcmService {
  static Future<void> setFcmToken(String fcmToken) async {
    final user = getIt<FirebaseAuth>().currentUser!;
    final userRef =
        getIt<FirebaseFirestore>().collection('users').doc(user.uid);
    await userRef.update({'fcmToken': fcmToken});
  }

  static Future<String> getFcmToken() async {
    final user = getIt<FirebaseAuth>().currentUser!;
    final userRef =
        getIt<FirebaseFirestore>().collection('users').doc(user.uid);
    final userSnapshot = await userRef.get();
    return userSnapshot['fcmToken'];
  }

  //!/11111111111111111111111111111111111111111111111
  static Future<String> _getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "just-chat-afd29",
      "private_key_id": "a81fe72ab2cf804cb34d0699d498fa0d7bb6ada2",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDIXRtHmr8eoFJR\npm5o0D4izhzLEoklJyOWfkFzSfPYieZYBU9SdiKIggIGhH2vNWdv7rBA0MkHEUw+\nhMqNJWwyPKAaK30RJQlB8d9VSXP5lVikt1KbSq1LYiyh0gy3KQ+zPrCuJk+g1PJR\nOtuugOM0pniPmsj7epXFdiia5Gd7e+O4dZpoywYvY3+dAmt4Z/F6RNcC6GkuE/i5\npnyT9Z1xHu45JHWWPs0NmA4PG5z907US2PkIbo9PzkytgR1DOcwacp8uuXMUrR+t\nQUwqF4TCj4xQ3zEI7EQzEDpIJu6iEeZAJfex66IR9fPvbusk4nWd6lxq36Hse6GR\nDRVSW57ZAgMBAAECggEAWJAPBs93uunSeRS/qMSjMm84eupuhGWQbWzRMUx25DfQ\nAQgXz7M4AG62xnq5s0A/wFIYxg2DTgRvVxMLFOh9spbpjae7WGCuft+Sf/g/swo4\nbFY7xTh08OUsJTrbM/qKXghPwCpe+BAoK4+AmtmNlDAhChi4za+Zk/ZubEiZFRMd\nlE6tZi2hqoF52VI8szCr7OZfQ+KfDPtN0hO4JgoSECoVknXcma2uJ8nW98k8Ubvy\ny6C8nnT9igtJqxPMVY4vh12zJsXqpVcX3rv5DjnjcvzuCDmbLi6f7fT76qWOx0nF\nB/NEGb7pUazX13n5l4kuIhRxi5+eClx2tpX/Ij4foQKBgQDkI884hePqZvRlfsBQ\njyBEJpJqxWSdQX2n0EjBrXfPbHTmpBgQaiyrh6gzJmOXXd49k8TYHd1yGvzrW5Bp\nhek3DLaUWri69PW9B4dQn5EHTN1itQi4wgFJZHF7cU0o6CBNN4wFEDVSRuForx/a\nh4by9iOHMRl2HhRIAiuAvLV6owKBgQDg1PK4zYZk4lpHMwHtnbnvGSNcztrM/Pft\nG7Cj1kgkvuspwp5ldYGx6Y0rtAvnsWtID7JruP4qt+LPV3olRQi1Gg+D5T5tOaW8\nPegmk8LIAPgTFLxaFy4pAOoF5QxPMUc/FvNYiPDk0iqWqo2NmLzP+JACZsyE8JmJ\nUtD8gnF0UwKBgEw0Vex4dLgAadRZMV33YPzCsZeulbwdex6J6TOggOutO6Mq3srk\n3ETzjFCBmzSdazXAXTkfSK/rqd3n+OX2j/8OZRJK93ejiU357M4Wbrg0iaKF/ALS\n8uEUBwAHyZFHcDq6ui+ayWTRPkvca1Rwfrg7VYS79thIldezudpHrornAoGBAN6j\nwWAjlgxc4c1Tw3sMD82ndQ84gA8yCkkwfHEhhvtsW+9UnAoYnMATaQp4FrnvRS9s\n6+Akpvyib+Wm2HwDqqW8EtUns/PxfB+2pidddysbWo16oTINdlaAYz5HHTNmtwjQ\nr1Vi9jmBrU7ZwacQMxk3KVRXe/vBTilgazdB7RulAoGAFPd6mRpeyFKza66K+TPC\nmv83fOJu7Vi7Se4wKj1poRkcsQpLbgXWHoAU6jCz14F8mk6W5tiynH+tmRA9opdQ\ngYdMXN8NO1TRaa8sHN5xB20K4SCZxNT0JIGxJRjbBfp/50sSrRZju3KLaEOPrExJ\nCrKgYgM/uYJATRszVMX3jVI=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "notificationservice@just-chat-afd29.iam.gserviceaccount.com",
      "client_id": "101419432975793270448",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/notificationservice%40just-chat-afd29.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    ///
    ///
    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);
    client.close();
    return credentials.accessToken.data;
  }

  static Future<void> sendNotification({
    required String opponentFcmToken,
    required MessageModel chatMsg,
    required String senderName,
  }) async {
    final String accessToken = await _getAccessToken();
    String endpointFCM =
        'https://fcm.googleapis.com/v1/projects/just-chat-afd29/messages:send';
    final Map<String, dynamic> fcmMsg = {
      "message": {
        'token': opponentFcmToken,
        "notification": {
          "title": senderName,
          "body": chatMsg.content,
        },
        "data": {
          "chatId": chatMsg.chatId,
          "type": "chat",
        }
      }
    };
/**
 * fLzaN0uJTMKahe8hl7cpIq:APA91bFDYNCMtkZ7Qi1ziJXmwcfXGyuyXAicE0qxnppTxeCey-
 * 4NtDSikdIo4rOFHjgY1XKtfgheyg3ukKE2JS6sC6rDlgOhoJ1UlBfcYsXGqsA4-
 * 1iqeO8N3Nlt4kwp7FNqgaPKvYVP
 */
    /// This http post will send the notification from user to another
    final http.Response response = await http.post(
      Uri.parse(endpointFCM),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(fcmMsg),
    );

    if (response.statusCode == 200) {
      print(
          '----------------------------------------Notification sent successfully--------------$senderName------------------');
    } else {
      print('Failed to send notification 000000000000000000000000000000');
    }
  }

  //!!!!!!!!!!!!!!!!!!!!!!!!!
  // It is assumed that all messages contain a data field with the key 'type'
  static Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      print('Notifactio here ====================000000');

      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  static void _handleMessage(RemoteMessage message) {
    print('Notifactio tapped ====================000000');
    // if (message.data['type'] == 'chat') {
    //   Navigator.pushNamed(context, '/chat',
    //     arguments: ChatArguments(message),
    //   );
    // }
  }
}
