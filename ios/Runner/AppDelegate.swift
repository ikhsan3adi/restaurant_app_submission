import Flutter
import UIKit
import workmanager

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    if(!UserDefaults.standard.bool(forKey: "Notification")) {
      UIApplication.shared.cancelAllLocalNotifications()
      UserDefaults.standard.set(true, forKey: "Notification")
    }
  
    WorkmanagerPlugin.setPluginRegistrantCallback { registry in
      GeneratedPluginRegistrant.register(with: registry)
    }
  
    WorkmanagerPlugin.registerBGProcessingTask(withIdentifier: "task-identifier")
  
    WorkmanagerPlugin.registerPeriodicTask(withIdentifier: "daily_reminder_task", frequency: NSNumber(value: 16 * 60))

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
