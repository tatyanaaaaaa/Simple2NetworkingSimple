//
//  RootCoordinator.swift
//  TetsThirdCoordinator
//
//  Created by Tatiana Sosina on 21.04.2022.
//

import UIKit

final class RootCoordinator: Coordinator {

    // MARK: - Private property
    
    private let window: UIWindow
    private let navigationController = UINavigationController()
    private var mainScreenCoordinator: Coordinator?
    
    // MARK: - Initialization
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Internal func
    
    func start() {
        let mainScreenCoordinator: Coordinator = MainScreenCoordinator(navigationController: navigationController)
        self.mainScreenCoordinator = mainScreenCoordinator
        mainScreenCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
