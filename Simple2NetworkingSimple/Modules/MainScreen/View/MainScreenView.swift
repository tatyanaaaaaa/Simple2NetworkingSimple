//
//  MainScreenView.swift
//  TetsThirdCoordinator
//
//  Created by Tatiana Sosina on 21.04.2022.
//

import UIKit

protocol MainScreenViewOutput: AnyObject {
    
    /// Была Выбрана ячейка с названием новостей
    func didSelectRow(newsTitle: String)
}

protocol MainScreenViewInput: AnyObject {
    
    /// Создать список новостей
    ///  - Parameter news: Список новостей
    func configureList(news: [String])
}

final class MainScreenView: UIView & MainScreenViewInput {
    
    // MARK: - Internal property
    
    weak var output: MainScreenViewOutput?
    
    // MARK: - Private property
    
    private let tableView = UITableView()
    private var news: [String] = []
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupDefaultSettings()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal func
    
    func configureList(news: [String]) {
        self.news = news
        tableView.reloadData()
    }
    
    // MARK: - Private func
    
    private func setupDefaultSettings() {
        backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Appearents().cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupConstraints() {
        [tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension MainScreenView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Appearents().cellIdentifier, for: indexPath)
        let oneNews = news[indexPath.row]
        cell.textLabel?.text = oneNews
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainScreenView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let titleNews = news[indexPath.row]
        output?.didSelectRow(newsTitle: titleNews)
    }
}

// MARK: - Appearents

private extension MainScreenView {
    struct Appearents {
        let cellIdentifier = "MyCell"
    }
}
