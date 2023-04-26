//
//  NetworkService.swift
//  testMobileUpGallery
//
//  Created by Dmitriy on 23.04.2023.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
   
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authServise) {
        self.authService = authService
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        

        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
   
        let url = self.url(from: path, params: allParams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }

    
    private func url(from path: String, params: [String: String]) -> URL {
        var component = URLComponents()
        
        component.scheme = API.scheme
        component.host = API.host
        component.path = API.photos
        component.queryItems = params.map { URLQueryItem(name: $0, value: $1)}

        return component.url!
    }
}
