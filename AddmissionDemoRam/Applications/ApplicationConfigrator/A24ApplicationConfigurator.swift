//
//  A24ApplicationConfigurator.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 25/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import RVNetworkStatus

protocol ApplicationConfiguratorInput {
    func configureInitialSettings(with rootViewController: UIViewController?)
}

class ApplicationConfigurator {
    
    private func configureAppearance() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
    }
    
    private func configureFrameworks() {
        // Environment update
        a24Environment = .live

        // Configure keyboard manager
        IQKeyboardManager.shared.enable = true

        //Auto network checker
        RVAutoNetworkStatus.configureSetup()
        
        //initialize sqlite databaes object
        RVSqliteDataProvider.shared.initDatabaes()

        
        var navigationController:UINavigationController?
        let details = A24SubjectDetailsRouter.setViewController(details: [:])
        navigationController = UINavigationController(rootViewController: details)

        navigationController?.isNavigationBarHidden = true
        APP_DELEGATE.window = UIWindow(frame: UIScreen.main.bounds)
        APP_DELEGATE.window?.rootViewController = navigationController
        APP_DELEGATE.window?.makeKeyAndVisible()
        
    }

}


// MARK: - ApplicationConfiguratorInput
extension ApplicationConfigurator: ApplicationConfiguratorInput {
    func configureInitialSettings(with rootViewController: UIViewController?) {
        configureAppearance()
        configureFrameworks()
        guard let _ = rootViewController as? UINavigationController else {
            print("Root View Controller must be UINavigationController")
            return
        }
    }
    
    var menuStoryboard: UIStoryboard {
        return UIStoryboard(name:"Menu", bundle: Bundle.main)
    }
    
}
