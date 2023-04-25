//
//  PhotoViewController.swift
//  testMobileUpGallery
//
//  Created by Dmitriy on 25.04.2023.
//

import UIKit

class PhotoViewController: UIViewController {


    var image = UIImage() 
    var dateUnix: Int? {
        didSet {
            guard let dateUnix = dateUnix else { return }
            let date1 = Date(timeIntervalSince1970: TimeInterval(dateUnix))
                let dateFormatter = DateFormatter()
//                dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                dateFormatter.dateStyle = DateFormatter.Style.long //Set date style
                dateFormatter.timeZone = .current
                date = dateFormatter.string(from: date1)
        }
    }
    var date: String?
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

            print("IMAGE \(self.image)")
//        imageView?.image = UIImage(systemName: "chevron.backward")
//        print("IMAGE VIEW \(imageView?.image)")
        

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
        print("DATA \(date)")
        navigationItem.title = date
    }
    
    @objc func shareMenuButton() {
        print("shareMenu")
    }
    

    func addImageView() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: (Int(view.bounds.height)/4), width: Int(view.bounds.width), height: Int(view.bounds.width)))
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        imageView.image = image
        
    }

}
