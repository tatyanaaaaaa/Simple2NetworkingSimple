//
//  Networking.swift
//  Simple2NetworkingSimple
//
//  Created by Tatiana Sosina on 22.04.2022.
//

import Foundation

protocol Networking {
    
    /// Получаем список новостей
    ///  - Parameter completion: захватывает список новостей
    func getNews(_ completion: ((NewsModel) -> Void)?)
}

final class NetworkingManager: Networking {
    func getNews(_ completion: ((NewsModel) -> Void)?) {
        let appearance = Appearance()
        let urlString = appearance.baseUrl + appearance.version + appearance.path
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = appearance.requestHTTPMethodGet
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        DispatchQueue.global(qos: .default).async {
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let news = try? JSONDecoder().decode(NewsModel.self, from: data) {
                        completion?(news)
                    } else {
                        print("Invalid Response")
                    }
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
            }.resume()
        }
    }
}

// MARK: - Appearance

private extension NetworkingManager {
    struct Appearance {
        let baseUrl = "https://api.spaceflightnewsapi.net"
        let path = "info"
        let version = "/v3/"
        
        let requestHTTPMethodGet = "GET"
        let requestHTTPMethodPost = "POST"
        let requestHTTPMethodPut = "PUT"
        let requestHTTPMethodDelete = "DELETE"
    }
}
