//
//  ViewController.swift
//  testMobileUpGallery
//
//  Created by Dmitriy on 21.04.2023.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!


    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            signInButton.layer.cornerRadius = 12
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = SceneDelegate.shared().authServise
        
        if Reachability.isConnectedToNetwork() == false {
            let alert = AlertController()
            alert.showAlertControlle(view: self, title: "There isn't internet connection")
        }
    }


    @IBAction func signInAction(_ sender: UIButton) {
        
        authService.wakeUpSession()
    }
    
}

