import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../constant/globals.dart';
import '../constant/salah_times.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future initialize() async {
    //const androidInitialize = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentSound: false,
    );
    const initializationsSettings = InitializationSettings(
      //android: androidInitialize,
      iOS: iosInitializationSettings,
    );

    await _notifications.initialize(initializationsSettings);
    _requestIOSPermissions();
  }

  static void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future showSoundNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id1',
      'your_channel_name1',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('ezan_1'), // Android için ses dosyası
      playSound: true,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: 'ezan_sia.wav', // iOS için ses
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _notifications.show(0, 'Hatırlatma', 'Namaz Vakti', platformChannelSpecifics);
  }

  static const MethodChannel _channel = MethodChannel('notifications');

  static Future<void> scheduleNotification({
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    try {
      await _channel.invokeMethod('scheduleWeeklyNotification', {
        "year": year,
        "month": month,
        "day": day,
        "hour": hour,
        "minute": minute,
        'title': title,
        'body': body,
      });
    } on PlatformException catch (e) {
      print("Bildirim planlanamadı: ${e.message}");
    }
  }

  static Future<void> cancelNotifications(String notificationID) async {
    const cancelNotifications = MethodChannel('cancel_notifications');
    try {
      await cancelNotifications.invokeMethod('cancel_notification', notificationID);
    } catch (e) {
      print("Bildirim iptal edilemedi: $e");
    }
  }

  static const MethodChannel getScheduledNotificationsChannel = MethodChannel('get_scheduled_notifications');

  static Future<void> getScheduledNotifications() async {
    try {
      final List<dynamic> notifications =
          await getScheduledNotificationsChannel.invokeMethod('getScheduledNotifications');
      Map<String, List<Map<String, dynamic>>> notificationsList = {};

      for (var notification in notifications) {
        final Map<String, dynamic> notificationMap = Map<String, dynamic>.from(notification);

        String dateKey = '${notificationMap['year']}-${notificationMap['month']}-${notificationMap['day']}';

        notificationsList.putIfAbsent(dateKey, () => []);

        // Bildirimi ilgili tarihe göre listeye ekle
        notificationsList[dateKey]!.add({
          'identifier': notificationMap['identifier'],
          'title': notificationMap['title'],
          'body': notificationMap['body'],
          'time': '${notificationMap['hour']}:${notificationMap['minute']}',
        });
      }
      Globals.notificationsList = notificationsList;
      print('SGlobals.notificationsList: ${Globals.notificationsList}');
    } catch (e) {
      print("Error fetching scheduled notifications: $e");
    }
  }

  static String? getNotificationsForSpecificDate(
      String date, Map<String, List<Map<String, dynamic>>> notificationsByDate, int index) {
    if (notificationsByDate.containsKey(date)) {
      return notificationsByDate[date]![index]['identifier'];
    } else {
      print('No notifications found for date: $date');
    }
    return null;
  }

  static Future<void> separateNotificationsByDate(
      Map<String, List<Map<String, dynamic>>> notificationList, String notificationName) async {
    String title = notificationName == SalahTimesNotification.fajr
        ? NotificationTitles.fajr
        : notificationName == SalahTimesNotification.dhuhr
            ? NotificationTitles.dhuhr
            : notificationName == SalahTimesNotification.asr
                ? NotificationTitles.asr
                : notificationName == SalahTimesNotification.maghrib
                    ? NotificationTitles.maghrib
                    : NotificationTitles.isha;

    for (var subList in notificationList.values) {
      for (var item in subList) {
        if (item['title'] == title) {
          await LocalNotificationService.cancelNotifications(item['identifier']);
        }
      }
    }
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    print("Tüm bekleyen bildirimler iptal edildi.");
  }
}
