//
//  GalleryViewController.swift
//  testMobileUpGallery
//
//  Created by Dmitriy on 22.04.2023.
//

import UIKit
import VK_ios_sdk

class GalleryViewController: UIViewController {
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcher.getFeed { feedResponse in
            guard let feedResponse = feedResponse else { return }
            print(feedResponse)
            
            self.addSignOutButton()
        }
    }
    
    func addSignOutButton() {
        let signOutButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(actionSignOutButton))
        navigationItem.rightBarButtonItem = signOutButton
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func actionSignOutButton() {
        print("выход")
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellGallery", for: indexPath) as! CellGallery
        let cellSize = view.bounds.width/2-1
        cell.heightAnchor.constraint(equalToConstant: cellSize).isActive = true
        cell.widthAnchor.constraint(equalToConstant: cellSize).isActive = true
        
        cell.backgroundColor = .systemGray5
        
        return cell
    }
}
