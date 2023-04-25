//
//  GalleryViewController.swift
//  testMobileUpGallery
//
//  Created by Dmitriy on 22.04.2023.
//

import UIKit
import VK_ios_sdk

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    private var feedResponse: FeedResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcher.getFeed { feedResponse in
            guard let feedResponse = feedResponse else { return }
            print(feedResponse)
            
            self.updateColectionView(feedResponse: feedResponse)
        }
        
        self.addSignOutButton()
    }
    
    func updateColectionView(feedResponse: FeedResponse) {
        self.feedResponse = feedResponse
        DispatchQueue.main.async {
            self.galleryCollectionView.reloadData()
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
        feedResponse?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellGallery", for: indexPath) as! CellGallery
        let cellSize = view.bounds.width/2-1
        cell.heightAnchor.constraint(equalToConstant: cellSize).isActive = true
        cell.widthAnchor.constraint(equalToConstant: cellSize).isActive = true
        let item = feedResponse?.items[indexPath.row]
        let date = item?.date
//        let size = item?.sizes[indexPath.row]
        let sizes = item?.sizes
        let sizeTypeZ = sizes?.filter{ $0.type == "z"}
      
        print("pum0 - \(sizeTypeZ)")
        
        let url = sizeTypeZ?.first?.url
            print("pum1\(url)")
            DispatchQueue.global().async {
                let imageUrl = URL(string: url!)
                print("pum2\(imageUrl)")
                let imageData = try? Data(contentsOf: imageUrl!)
                DispatchQueue.main.async {
                    cell.imageCellGallery.image = UIImage(data: imageData!)
//                    self.galleryCollectionView.reloadData()
                }
            }

        
        
        
        cell.backgroundColor = .systemGray5
        
        return cell
    }
}
