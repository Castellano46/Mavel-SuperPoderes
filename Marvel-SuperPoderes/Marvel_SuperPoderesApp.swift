//
//  Marvel_SuperPoderesApp.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 14/11/23.
//

import SwiftUI

@main
struct Marvel_SuperPoderesApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var rootViewModel = RootViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(rootViewModel)
        }
    }
}
