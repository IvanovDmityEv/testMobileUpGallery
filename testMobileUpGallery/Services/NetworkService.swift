//
//  NetworkService.swift
//  testMobileUpGallery
//
//  Created by Dmitriy on 23.04.2023.
//

import Foundation

final class NetworkService {
    
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authServise) {
        self.authService = authService
    }
    
    func getFeed() {
        
        
        guard let token = authService.token else { return }
        
        let params = ["owner_id":"-128666765", "album_id":"-266310117"]
        var allParams = params
        allParams["acces_token"] = token
        allParams["v"] = API.version
   
        let url = self.url(from: API.photos, params: allParams)
        
        print(url)
        
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
