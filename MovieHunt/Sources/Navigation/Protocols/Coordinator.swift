//
//  Coordinator.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 17/2/26.
//

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }

    func start()
}

extension Coordinator {
    func addChild(_ child: Coordinator) {
        childCoordinators.append(child)
    }

    func removeChild(_ child: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== child }  // means Keep all coordinators that are NOT the same instance as child
    }
}
