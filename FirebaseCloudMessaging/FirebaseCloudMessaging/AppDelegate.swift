//
//  AppDelegate.swift
//  FirebaseCloudMessaging
//
//  Created by 濵田　悠樹 on 2022/03/03.
//

// AppDelegate は FCM の設定のみを行う
import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // 起動時に実行, 画面の指定を行うとうまく画面が表示されない(Storyboardなしの場合)ため、画面の描画はSceneDelegateで行う
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
       // Override point for customization after application launch.
       FirebaseApp.configure()
       Messaging.messaging().delegate = self
       
       // iOS 10 以降
       if #available(iOS 10.0, *) {
           // For iOS 10 display notification (sent via APNS)
           UNUserNotificationCenter.current().delegate = self

           let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
           UNUserNotificationCenter.current().requestAuthorization(
               options: authOptions,
               completionHandler: {_, _ in })
       } else {
           let settings: UIUserNotificationSettings =
               UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
           application.registerUserNotificationSettings(settings)
       }

       print("application.registerForRemoteNotifications()")
       application.registerForRemoteNotifications()   // didRegisterForRemoteNotificationsWithDeviceToken: のデリゲートを呼び出す
       
       return true
   }

   // MARK: UISceneSession Lifecycle
   func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       // Called when a new scene session is being created.
       // Use this method to select a configuration to create the new scene with.
       return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
   }

   func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       // Called when the user discards a scene session.
       // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
       // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
   }

   func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
       // Print message ID.
       if let messageID = userInfo["gcm.message_id"] {
           print("Message ID: \(messageID)")
       }

       // Print full message.
       print(userInfo)
   }

    // サイレント プッシュ通知を処理, バックグラウンドでのデータ更新
   func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
       // Print message ID.
       if let messageID = userInfo["gcm.message_id"] {
           print("Message ID: \(messageID)")
       }

       // Print full message.
       print(userInfo)
       
//       Messaging.messaging().delegate = self
//       Messaging.messaging().token { token, error in
//         if let error = error {
//           print("Error fetching FCM registration token: \(error)")
//         } else if let token = token {
//           print("FCM registration token: \(token)")
//           self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
//         }
//       }
       
       completionHandler(UIBackgroundFetchResult.newData)
   }
    
    // デバイストークンの更新を行う
    func application(_ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      print("Messaging.messaging().apnsToken = deviceToken")
      Messaging.messaging().apnsToken = deviceToken
    }
}

// MARK: FCM の Delegate
// FCM からディスプレイ通知を受信する
@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // ...

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.alert, .sound]])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    // ...

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
    print(userInfo)

    completionHandler()
  }
}

// トークンを表示する
extension AppDelegate : MessagingDelegate {
    // トークン更新のモニタリング
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      // コンソールに登録トークンを出力する
      print("Firebase registration token: \(String(describing: fcmToken))")   // トークンを表示

      // 登録トークンが新規の場合、アプリケーションサーバーに送信
      let dataDict:[String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }

}
