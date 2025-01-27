import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller = window?.rootViewController as! FlutterViewController
    let notificationChannel = FlutterMethodChannel(name: "notifications", binaryMessenger: controller.binaryMessenger)
    let cancelNotificationChannel = FlutterMethodChannel(name: "cancel_notifications", binaryMessenger: controller.binaryMessenger)
    let getNotifications = FlutterMethodChannel(name: "get_scheduled_notifications", binaryMessenger: controller.binaryMessenger)

    UNUserNotificationCenter.current().delegate = self

     UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
       if granted {
         print("Bildirim izni verildi.")
       } else {
         print("Bildirim izni reddedildi.")
       }
     }

    // Method Channel Handler
    getNotifications.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "getScheduledNotifications" {
        self.getScheduledNotifications(result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

notificationChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
    if call.method == "scheduleWeeklyNotification" {
        if let args = call.arguments as? [String: Any],
           let year = args["year"] as? Int,
           let month = args["month"] as? Int,
           let day = args["day"] as? Int,
           let hour = args["hour"] as? Int,
           let minute = args["minute"] as? Int,
           let title = args["title"] as? String,
           let body = args["body"] as? String {

            var dateComponents = DateComponents()
            dateComponents.year = year
            dateComponents.month = month
            dateComponents.day = day
            dateComponents.hour = hour
            dateComponents.minute = minute

            self.scheduleWeeklyNotification(with: dateComponents, title: title, body: body)
            print("Haftalık bildirim eklendi: title: \(title), body: \(body), day: \(day), hour: \(hour), minute: \(minute)")
            result(nil)
        } else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Argümanlar geçersiz", details: nil))
        }
    } else {
        result(FlutterMethodNotImplemented)
    }
}


cancelNotificationChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
    if call.method == "cancel_notification" {
        // 'identifier' parametresini alıyoruz
        if let identifier = call.arguments as? String {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
            print("Bildirim iptal edildi: \(identifier)")
            result(nil)
        } else {
            // 'identifier' parametresi eksikse hata döndür
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Bildirim identifier eksik", details: nil))
        }
    } else {
        result(FlutterMethodNotImplemented)
    }
}


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

private func scheduleWeeklyNotification(with dateComponents: DateComponents, title: String, body: String) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound(named: UNNotificationSoundName("ezan_sia.wav"))

    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Bildirim eklenirken hata oluştu: \(error)")
        }
    }
}


        // Bekleyen bildirimleri almak için iOS fonksiyonu
        private func getScheduledNotifications(result: @escaping FlutterResult) {
          UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            var notifications: [[String: Any]] = []

            for request in requests {
              guard let trigger = request.trigger as? UNCalendarNotificationTrigger else { continue }

              let identifier = request.identifier
              let title = request.content.title
              let body = request.content.body
              let dateComponents = trigger.dateComponents

              // Date components bilgilerini alıyoruz
              let year = dateComponents.year ?? 0
              let month = dateComponents.month ?? 0
              let day = dateComponents.day ?? 0
              let hour = dateComponents.hour ?? 0
              let minute = dateComponents.minute ?? 0

              let notificationData: [String: Any] = [
                "identifier": identifier,
                "title": title,
                "body": body,
                "year": year,
                "month": month,
                "day": day,
                "hour": hour,
                "minute": minute
              ]
              notifications.append(notificationData)
            }
            result(notifications)
          }
        }
}
