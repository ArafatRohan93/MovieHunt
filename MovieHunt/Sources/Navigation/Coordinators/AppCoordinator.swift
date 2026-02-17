//
//  AppCoordinator.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 17/2/26.
//

import UIKit
import SwiftUI

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    init(window: UIWindow){
        self.window = window
    }
    
    
    func start() {
        // main entrypoint
        //decisions like if user is logged in to to tab else go to login etc
        showMainFlow()
    }
    
    private func showMainFlow() {
        
        let tabCoordinator = MainTabCoordinator()
        
        addChild(tabCoordinator)
        
        tabCoordinator.start()
        
        window.rootViewController = tabCoordinator.getTabBarController()
        window.makeKeyAndVisible()
        
        
        AppLogger.log("AppCoordinator: Main Tab Flow started", category: .navigation)
    }
}
