//
//  V_FIT2App.swift
//  V-FIT2
//
//  Created by SAIL on 05/06/25.
//

import SwiftUI
import UserNotifications

@main
struct V_FIT2App: App {
    init() {
        // Request permission for notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("✅ Notification permission granted.")
            } else {
                print("❌ Notification permission denied.")
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WelcomeView()
            }
        }
    }
}
