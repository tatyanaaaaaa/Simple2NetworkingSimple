//
//  MainScreenInteractor.swift
//  TetsThirdCoordinator
//
//  Created by Tatiana Sosina on 21.04.2022.
//

import UIKit

protocol MainScreenInteractorOutput: AnyObject {
    
    /// Были получены заголовки новостей
    /// - Parameter news: новости
    func didRecive(news: [String])
}

protocol MainScreenInteractorInput: AnyObject {
    
    /// Загрузить данные
    func getContent()
}

final class MainScreenInteractor: MainScreenInteractorInput {
    
    // MARK: - Internal property
    
    weak var output: MainScreenInteractorOutput?
    
    // MARK: - Private property
    
    private let networking: Networking
    
    // MARK: - Initialization
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getContent() {
        networking.getNews { [weak self] result in
            DispatchQueue.main.async {
                self?.output?.didRecive(news: result.newsSites)
            }
        }
    }
}
