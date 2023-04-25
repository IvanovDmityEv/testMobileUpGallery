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

        let url = getUrlString(item: item)
        getImage(urlString: url) { imageData in
            DispatchQueue.main.async {
                cell.imageCellGallery.image = UIImage(data: imageData!)
            }
        }
        return cell
    }
    

    
    func getUrlString (item: FeedItem?) -> String? {
        let sizes = item?.sizes
        guard let sizes = sizes else {return nil}
        let sizeTypeZ = sizes.filter{ $0.type == "z"}
        let urlString = sizeTypeZ.first?.url
        return urlString
    }
    
    func getImage (urlString: String?, completionHandler: @escaping (Data?)->()) {
        guard let urlString = urlString else { return }
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: urlString) else {return}
            print("pum2\(imageUrl)")
            guard let imageData = try? Data(contentsOf: imageUrl) else {return}
            completionHandler(imageData)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoVC = PhotoViewController()
        let item = feedResponse?.items[indexPath.row]
        let urlString = getUrlString(item: item)

        getImage(urlString: urlString) { imageData in
                photoVC.image = UIImage(data: imageData!) ?? UIImage()
                print("SELECTED IMAGE \(photoVC.image)")
            if photoVC.image != UIImage() {
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(photoVC, animated: true)
                }
                
            }
        }
        
//        DispatchQueue.main.async {
//
//                   }

        photoVC.dateUnix = item?.date

    }
}
