//
//  MainScreenCoordinator.swift
//  TetsThirdCoordinator
//
//  Created by Tatiana Sosina on 21.04.2022.
//

import UIKit

final class MainScreenCoordinator: Coordinator {
    
    // MARK: - Private property
    
    private let navigationController: UINavigationController
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Internal func
    
    func start() {
        let mainScreenModule = MainScreenAssembly().createModule()
        navigationController.pushViewController(mainScreenModule, animated: true)
    }
}
