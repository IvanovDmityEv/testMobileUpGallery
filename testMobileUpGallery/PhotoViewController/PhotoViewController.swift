//
//  PhotoViewController.swift
//  testMobileUpGallery
//
//  Created by Dmitriy on 25.04.2023.
//

import UIKit
import VK_ios_sdk

class PhotoViewController: UIViewController {


    var image = UIImage() 
    var dateUnix: Int? {
        didSet {
            guard let dateUnix = dateUnix else { return }
            let date1 = Date(timeIntervalSince1970: TimeInterval(dateUnix))
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = DateFormatter.Style.long
                dateFormatter.timeZone = .current
                date = dateFormatter.string(from: date1)
        }
    }
    var date: String?
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addButtonItems()
        addImageView()
    }

    
    func addButtonItems() {
        let shareMenuButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "square.and.arrow.up"), target: self, action: #selector(shareMenuButton))

        navigationItem.backBarButtonItem = .none
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.rightBarButtonItem = shareMenuButton
        navigationController?.navigationBar.tintColor = .black
        guard let date = date else { return }
        navigationItem.title = date
    }
    
    @objc func shareMenuButton() {
        let items: [Any] = [image]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        avc.completionWithItemsHandler = {_, bool, _, _ in
            if bool {
                let alert = AlertController()
                alert.showAlertControlle(view: self, title: "Изображение сохранено")
            }
        }
        self.present(avc, animated: true)
    }
    

    func addImageView() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Int(view.bounds.width), height: Int(view.bounds.height)))
        imageView.contentMode = .scaleAspectFit  
        view.addSubview(imageView)
        imageView.image = image
    }
}
