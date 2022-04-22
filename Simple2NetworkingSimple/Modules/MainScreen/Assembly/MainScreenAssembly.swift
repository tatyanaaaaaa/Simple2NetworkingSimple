//
//  MainScreenAssembly.swift
//  TetsThirdCoordinator
//
//  Created by Tatiana Sosina on 21.04.2022.
//

import UIKit

final class MainScreenAssembly {
    func createModule() -> MainScreenModule {
        
        let networking = NetworkingManager()
        let view = MainScreenView()
        let interactor = MainScreenInteractor(networking: networking)
        let presenter = MainScreenModuleViewController(moduleView: view,
                                                       interactor: interactor)
        
        interactor.output = presenter
        view.output = presenter
        return presenter
    }
}
