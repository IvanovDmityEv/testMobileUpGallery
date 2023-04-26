//
//  AlertController.swift
//  testMobileUpGallery
//
//  Created by Dmitriy on 26.04.2023.
//

import Foundation
import UIKit


class AlertController {
    
    func showAlertControlle(view: UIViewController, title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.view.tintColor = .black
        let actionOk = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(actionOk)
        DispatchQueue.main.async {
            view.present(alertController, animated: true, completion: nil)
          }
    }
}
