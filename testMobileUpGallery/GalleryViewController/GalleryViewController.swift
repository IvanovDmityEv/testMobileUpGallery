//
//  GalleryViewController.swift
//  testMobileUpGallery
//
//  Created by Dmitriy on 22.04.2023.
//

import UIKit

class GalleryViewController: UIViewController {
    
    private var networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.getFeed()
    }
}
