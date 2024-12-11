//
//  AngeloAppApp.swift
//  AngeloApp
//
//  Created by Joseph Brinker on 9/27/24.
//

import SwiftUI

@main
struct AngeloApp: App {
    @StateObject private var model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
