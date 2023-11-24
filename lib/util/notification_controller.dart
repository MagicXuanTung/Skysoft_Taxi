import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

void sendNotificationOrder() {
  String title = "Đang gửi thông báo";
  String body = "Đã có thông báo!";
  NotificationController.createOrderStaffNotification(title, body);
}

class NotificationController {
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        null, //'resource://drawable/res_app_icon',//
        [
          NotificationChannel(
              channelKey: 'order_channel',
              channelName: 'order_channel',
              channelDescription: 'Notification for order staff',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: const Color(0xFF036292),
              ledColor: Colors.white),
          NotificationChannel(
              channelKey: 'kitchen_channel',
              channelName: 'kitchen_channel',
              channelDescription: 'Notification for kitchen staff',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: const Color(0xFF036292),
              ledColor: Colors.white)
        ],
        debug: false);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.channelKey == "order_channel") {
      log("order_channel");
      // MyApp.navigatorKey.currentState?.push(
      //     MaterialPageRoute(builder: (context) => ConfirmServingScreen()));
    } else if (receivedAction.channelKey == "kitchen_channel") {
      log("kitchen_channel");
      // MyApp.navigatorKey.currentState?.push(MaterialPageRoute(
      //     builder: (context) =>
      //         KitchenScreen(restaurantID: Global.restaurantID)));
    }
  }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  static Future<bool> displayNotificationRationale() async {
    return await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  ///  *********************************************
  ///     NOTIFICATION CREATION METHODS
  ///  *********************************************
  ///
  static Future<void> createOrderStaffNotification(
      String title, String body) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1, // -1 is replaced by a random number
        channelKey: 'order_channel',
        title: title,
        body: body,
        largeIcon:
            'https://play-lh.googleusercontent.com/RIU1oM-b4OadLlOuvhwvuzjw1fVh54gHNq-CQfT2UdOzOG6rajBVqPm3wkkKirxyPr0=s220',
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  static Future<void> createKitchenNotification(
      String title, String body) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1, // -1 is replaced by a random number
        channelKey: 'kitchen_channel',
        title: title,
        body: body,
        largeIcon:
            'https://play-lh.googleusercontent.com/RIU1oM-b4OadLlOuvhwvuzjw1fVh54gHNq-CQfT2UdOzOG6rajBVqPm3wkkKirxyPr0=s220',
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}
