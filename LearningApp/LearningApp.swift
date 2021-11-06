//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Zharikova on 11/5/21.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
