import 'package:dio/dio.dart';
import 'package:firebase_cloud_messaging_flutter/firebase_cloud_messaging_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Sendnotificationscreen extends StatelessWidget {
  Sendnotificationscreen({super.key});
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Notification"),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Enter title",
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: bodyController,
            decoration: InputDecoration(
              hintText: "Enter body",
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: ElevatedButton(
              onPressed: () async {

                final serviceAccountFileContent = <String, String>{
                  "type": "service_account",
                  "project_id": "king-developers",
                  "private_key_id": "48cfe1b42269a3ce16f47d7d57f9786fc3066b9d",
                  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCm+F+xnMOuBX9r\nZQCBTA2eJfaGsteapT1hRXF5wYj4tUw1elezfQUFEYAiIUdb4NSe5W0arBxnagMI\nkCEwH+DuHIgZ0EOsyVmYMsDdftWhyN9FH+VBQ6OxNYVvmD27v0Mlwus31iXtPVXq\nbUw6lhlLwotUEbAsUHxX1hcyCogsKbYUBDV5q8fIvRhl3RQOvG7klSw9eku6h9Ua\nHAlBI5H0tBCZE8P+9UzIM/pnU3qhsfTvypCgIN5SKVsjnzsqJLMCTrYFNgPOpMzW\no4i6q8Rc9LNHj9KB1ySmiNFYeGW68QO6HRPmumlo2u9M1KxK0Ip+RKShu1tCbjW8\nHO+S7zGXAgMBAAECggEAB9SnzqsNFYd2E/ggr4lJk8+XLqoK9cDzwZdOj+je66S7\ndkA1BlrB3LYwmpxeisiSMDTCV5KxO+7IEnBWauz6N5cCKw1bBZEYsP9wXCYrdSYr\nX0Qnre/mKKF1KJt5o0+zbn0kJ78IK4aWfCNNt+tImtNjUjk7vr60Yv1l1eSSJ/My\n7xGzgNWDc089CrltcuL7vzKO8yuEhYwD9FQYKlXNpaZV+pnlOPlYiQi+bbAdCKWS\nDIevAW9tdZU8Jihi2R2MesTPsO6+II1NSYc40kTdxQiYSOgfeXTkV9SZ9WBKNio/\nX9fH/MVmk0h3yYNjsODgKFhafETyWyC0oHHLV661AQKBgQDm94X23aX66KK5bnWh\nreB3sCcKJJ7Psm2YGbWWcbVg0NjtpXs1XykfVOGXDj7/E7pxKiGLo/1zbhRSUXew\nifoswEE2ZjjZMRrG5dAbER9ZvN0lY4V6Ib9YKrF73GMivRRH8UZF9valz6aPpis8\nM9QFEYVIMo7JaK7QyXlJg5u+MQKBgQC5ES3wTj6/NsRi7yLNK+rfKz4t4VjpWkgW\n3APb0d14A/DSpgv6dlaldNCAIV0mvEJRW0345eFpJBdJ+I54goxoP0epyX9PdHmL\nkZEAIOEJLzhtYfDcLNKNMJoES6d8jp2BPaYLQjTCebNijRO/sVNSrs3Iyugvwxqz\nWC9Cp74SRwKBgFhb+XQn94e12Ar4pyfjTSx8x3Kp79eleyflLgMQHUOcomDIHgqd\nDS5fWq5fVNpgwcLpS0wQwLWYN04GvLNdFchpBIm7MaRllMjiwmqYclXyWugi2r2O\ni5U/QAcSmRqBG3EqbKf3gwSMHDx4ZbHyYfpOaZ7lOJr04Wwep7foEX0BAoGABP7S\nt57VEMJAsM71qIYb8+Qt7H0dskbOlVdg/0j96mRo1rbGsf8JvbOWgS7lXctNGvcU\n9rf1yqm/uy5rYhNcCOBUZd/bgOCK+1p1iIRarq3InyM6pibLlCYQsjb8kV8kHz3z\nwnAKDonMbseSFeWKczvmsBnSBKAGk3q449q1RbcCgYAsj7jfgjVveqrxqjItN2DS\n0Numg5itpxzw0/Vd17ShVyxszqOduMzc8l4DoEyq4iPh7Ugbx4FpegSaxr996pVa\n5v/b8Du1ytTDsKVkqQUQhu5diJEnTjuNb1kc/feVowhbni+wBUmyNzAfWKLSKxcD\n4nrVO4wVf9w/46y20B0W8g==\n-----END PRIVATE KEY-----\n",
                  "client_email": "firebase-adminsdk-idqeq@king-developers.iam.gserviceaccount.com",
                  "client_id": "109635489476401761415",
                  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
                  "token_uri": "https://oauth2.googleapis.com/token",
                  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
                  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-idqeq%40king-developers.iam.gserviceaccount.com",
                  "universe_domain": "googleapis.com"
                };

                /// Add Your Service Account File Content as Map
                var server = FirebaseCloudMessagingServer(
                  serviceAccountFileContent,
                );

                /// Send a Message
                var result = await server.send(
                  FirebaseSend(
                    validateOnly: false,
                    message: FirebaseMessage(
                      notification: FirebaseNotification(
                        title: 'Package by Ottoman',
                        body: 'Ottoman added something new! 🔥',
                      ),
                      android: FirebaseAndroidConfig(
                        ttl: '2s',

                        /// Add Delay in String. If you want to add 1 minute delat then add it like "60s"
                        notification: FirebaseAndroidNotification(
                          icon: 'ic_notification',
                          color: '#009999',
                        ),
                      ),
                      topic: "all",
                      // token: token,
                    ),
                  ),
                );
                print(result);

                // Dio dio = Dio();
                // dio.post("https://fcm.googleapis.com/fcm/send",data: {
                //   "to": "/topics/all",
                //   "notification": {
                //     "title": "Check this Mobile (title)",
                //     "body": "Rich Notification testing (body)",
                //   },
                //
                // }, options: Options(
                //   headers: {
                //     "Content-Type": "application/json",
                //     "Authorization": "key=AAAAQsS35M0:APA91bH8BAykk6jmSyIs8M2MJALrOR6xG9zSfa89PxThX6Xg7xQXe9ZjBvLQLZKJyTI9KCN3kL18iHpkVzcGja5D55HUCKC5F8QTOVwGlJ0g-xF1h14Qd2BOUt_ZS1melCInw-ONtvXh"
                //   }
                // ));
              },
              child: Text("Send"),
            ),
          )
        ],
      ),
    );
  }
}
