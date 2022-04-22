//
//  MainScreenModule.swift
//  TetsThirdCoordinator
//
//  Created by Tatiana Sosina on 21.04.2022.
//

import UIKit

protocol MainScreenModuleOutput: AnyObject {
    
}

protocol MainScreenModuleInput: AnyObject {
    
    var moduleOutput: MainScreenModuleOutput? { get set }
}

typealias MainScreenModule = UIViewController & MainScreenModuleInput

final class MainScreenModuleViewController: MainScreenModule {
    
    // MARK: - Internal property
    
    weak var moduleOutput: MainScreenModuleOutput?
    
    // MARK: - Private property
    
    private let moduleView: MainScreenViewInput & UIView
    private let interactor: MainScreenInteractorInput
    
    // MARK: - Initialization
    
    init(moduleView: MainScreenViewInput & UIView, interactor: MainScreenInteractorInput) {
        self.moduleView = moduleView
        self.interactor = interactor
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal func
    
    override func loadView() {
        super.loadView()
        view = moduleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.getContent()
        title = Appearents().titleLabel
    }
}

// MARK: - MainScreenViewOutput

extension MainScreenModuleViewController: MainScreenViewOutput {
    func didSelectRow(newsTitle: String) {
        title = newsTitle
    }
}

// MARK: - MainScreenInteractorOutput

extension MainScreenModuleViewController: MainScreenInteractorOutput {
    func didRecive(news: [String]) {
        moduleView.configureList(news: news)
    }
}

// MARK: - Appearents

private extension MainScreenModuleViewController {
    struct Appearents {
        let titleLabel = "Main screen"
    }
}
