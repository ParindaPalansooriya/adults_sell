import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class AWNotification{

  ///minSdkVersion 21
  ///targetSdkVersion 31
  ///compileSdkVersion 31
  ///ext.kotlin_version = '1.5.31'
  ///add this to android AndroidManifest.xml file    android:exported="true"
  ///add image to android\app\src\main\res\drawable file to use icon on notification
  ///     view nad add that image image as a "androidImageNameOnDrawableFolder" on init() method
  /// == also this drawable folder image add to AndroidManifest.xml file like this
  ///     <application
  ///         android:label="Flutter Awesomdialog Fcm"
  ///         android:icon="@mipmap/launcher_icon">
  ///        <meta-data
  ///            android:name="com.google.firebase.messaging.default_notification_icon"
  ///            android:resource="@drawable/notification" />
  ///
  ///IOS required the minimum iOS version to 10. You can change the
  ///     minimum app version through xCode, Project Runner (clicking on the app icon) > Info > Deployment Target
  ///     and changing the option "ios minimum deployment target" to 10.0
  ///
  /// Steps
  /// 1 : add init() method on main.dart before the runApp() method
  /// 2 : check permission using checkPermission() on first page you load in app like splash or home page.
  /// 3 : you need to call this method onNotificationClick() inside the initState() on first page at closing start.
  /// 4 : you need to call closeAll() method inside the dispose() on last page at closing app.

  // AWNotification.checkPermission(BuildContext context){
  //   AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
  //     if (!isAllowed) {
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: const Text('Allow Notifications'),
  //           content: const Text('Our app would like to send you notifications'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text(
  //                 'Don\'t Allow',
  //                 style: TextStyle(
  //                   color: Colors.grey,
  //                   fontSize: 18,
  //                 ),
  //               ),
  //             ),
  //             TextButton(
  //                 onPressed: () => AwesomeNotifications()
  //                     .requestPermissionToSendNotifications()
  //                     .then((_) => Navigator.pop(context)),
  //                 child: const Text(
  //                   'Allow',
  //                   style: TextStyle(
  //                     color: Colors.teal,
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ))
  //           ],
  //         ),
  //       );
  //     }else{
  //       print("alluwed");
  //     }
  //   });
  // }
  //
  // AWNotification.onNotificationCreate(Function(ReceivedNotification notification) function){
  //   AwesomeNotifications().createdStream.listen(function);
  //   AwesomeNotifications().
  // }
  //
  // AWNotification.onNotificationClick(Function(ReceivedNotification notification)? function){
  //   AwesomeNotifications().actionStream.listen((val){
  //     if (val.channelKey == 'basic_channel' && Platform.isIOS) {
  //       AwesomeNotifications().getGlobalBadgeCounter().then(
  //             (value) =>
  //             AwesomeNotifications().setGlobalBadgeCounter(value - 1),
  //       );
  //     }
  //     if(function!=null){
  //       function(val);
  //     }
  //   });
  // }
  //
  // AWNotification.closeAll(){
  //   AwesomeNotifications().actionSink.close();
  //   AwesomeNotifications().createdSink.close();
  // }
  //
  // AWNotification.show({required String title,required String body,int? id}){
  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: id??DateTime.now().millisecondsSinceEpoch.remainder(100000),
  //       channelKey: 'basic_channel',
  //       title: title,
  //       body: body,
  //       notificationLayout: NotificationLayout.BigText,
  //     ),
  //   );
  // }
  //
  // AWNotification.init({required String androidImageNameOnDrawableFolder, required Color notificationColor}){
  //   AwesomeNotifications().initialize(
  //     'resource://drawable/'+androidImageNameOnDrawableFolder,
  //     [
  //       NotificationChannel(
  //         channelKey: 'basic_channel',
  //         channelName: 'Basic Notifications',
  //         defaultColor: notificationColor,
  //         channelDescription: 'Notification channel for Mobile App',
  //         importance: NotificationImportance.High,
  //         channelShowBadge: true,
  //       ),
  //     ],
  //   );
  // }
}