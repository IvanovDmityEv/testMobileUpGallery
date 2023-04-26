//
//  AuthService.swift
//  testMobileUpGallery
//
//  Created by Dmitriy on 22.04.2023.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(_ viewControlle: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "51621784"
    private let vkSdk: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        VKSdk.accessToken().accessToken
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["photos"]
        
        VKSdk.wakeUpSession(scope) { [weak self] state, error in
            switch state {
            case .authorized:
                print("authorized")
                self?.delegate?.authServiceSignIn()
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)

            default:
                self?.delegate?.authServiceDidSignInFail()
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
        
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceDidSignInFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
