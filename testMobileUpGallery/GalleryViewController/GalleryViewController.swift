//
//  GalleryViewController.swift
//  testMobileUpGallery
//
//  Created by Dmitriy on 22.04.2023.
//

import UIKit

class GalleryViewController: UIViewController {
    
//    private var networkService: Networking = NetworkService()
//    let params = ["owner_id":"-128666765", "album_id":"266310117"]
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
//    -266310117
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcher.getFeed { feedResponse in
            guard let feedResponse = feedResponse else { return }
            print(feedResponse)
        }

//        networkService.request(path: API.photos, params: params) { data, error in
//            if error != nil {
//                print("Error recived requesting data")
//            }
//
//            let decoder = JSONDecoder()
////            decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//            guard let data = data else { return }
////            let json = try? JSONSerialization.jsonObject(with: data)
////            print(json)
//
//            let response = try? decoder.decode(FeedResponseWrapped.self, from: data)
//            print(response)
//        }
    }
}
