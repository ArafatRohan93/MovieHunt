//
//  MovieHuntApp.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 17/2/26.
//

import SwiftUI

@main
struct MovieHuntApp: App {

    @State private var appCoordinator: AppCoordinator?

    var body: some Scene {
        WindowGroup {
            Color.clear.onAppear {
                configureCoordinator()
            }
        }
    }

    private func configureCoordinator() {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first
                as? UIWindowScene,
            let window = windowScene.windows.first
        else {
            return
        }

        let coordinator = AppCoordinator(window: window)
        self.appCoordinator = coordinator
        coordinator.start()
    }
}
