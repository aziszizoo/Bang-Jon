//
//  MyBarbershopApp.swift
//  MyBarbershop
//
//  Created by ZISACHMAD on 10/05/21.
//

import SwiftUI
import StreamChat
import Firebase

@main
struct BangJon: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject,UIApplicationDelegate {
    
    @AppStorage("UserName") var storedUser = ""
    @AppStorage("log_Status") var logStatus = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()

        let config = ChatClientConfig(apiKeyString: APIKey)
        
        // JIKA USER BERHASIL LOGIN
        if logStatus {
            ChatClient.shared = ChatClient(config: config, tokenProvider: .development(userId: storedUser))
        }
        else {
            ChatClient.shared = ChatClient(config: config, tokenProvider: .anonymous)
        }
        return true
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
}

// STREAM API
extension ChatClient {
    static var shared: ChatClient!
}
