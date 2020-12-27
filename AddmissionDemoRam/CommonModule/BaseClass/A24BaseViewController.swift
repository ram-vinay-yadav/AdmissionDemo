//
//  A24BaseViewController.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 25/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//

import UIKit
import RVNetworkStatus

class A24BaseViewController: UIViewController {
    
    //MARK:- IBOutlets here
    
    //MARK:- variables declerations
    internal var isFirstTimeConnection:Bool = false

    var activityIndicatorContainerView: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    lazy var backgroundView : UIView = {
        let v = UIView()
        v.frame = UIScreen.main.bounds
        v.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return v
        
    }()

    
    //MARK:- controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCommonDesign()
    }
    
    //MARK:- common ui design setup here
    internal func setUpCommonDesign() {
        NotificationCenter.default.addObserver(self,selector: #selector(statusManager),name: .rvNetworkFlagsChanged,object: nil)
        self.updateUserInterface()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.isDarkModeOn == true ? .lightContent : .default
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
}

//MARK:- Activity Indicator View
extension A24BaseViewController {
    
    func showActivityIndicator(uiView: UIView) {
        activityIndicatorContainerView.frame = uiView.frame
        activityIndicatorContainerView.center = uiView.center
        activityIndicatorContainerView.backgroundColor = .clear
    
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = .red
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 4
    
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);

        loadingView.addSubview(activityIndicator)
        activityIndicatorContainerView.addSubview(loadingView)
        uiView.addSubview(activityIndicatorContainerView)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        activityIndicatorContainerView.removeFromSuperview()
    }
}

//MARK:- Add more funcunality here
extension A24BaseViewController {
    
    func updateUserInterface() {
        
        switch RVNetwork.reachability.status {
        case .unreachable:
            self.isFirstTimeConnection = true
            view.showMessage("No Internet Connection", type: .error)
        case .wwan:
            if isFirstTimeConnection {
                view.showMessage("Internet Connected", type: .success)
            }
        case .wifi:
            if isFirstTimeConnection {
                view.showMessage("Internet Connected", type: .success)
            }
        }
        
        debugPrint("RVNetwork Summary")
        debugPrint("Status:", RVNetwork.reachability.status)
        debugPrint("HostName:", RVNetwork.reachability.hostname ?? "nil")
        debugPrint("Reachable:", RVNetwork.reachability.isReachable)
        debugPrint("Wifi:", RVNetwork.reachability.isReachableViaWiFi)
    }
    
    @objc func statusManager(_ notification: Notification) {
        self.updateUserInterface()
    }
}


public extension UIViewController {
    var isDarkModeOn: Bool {
        if #available(iOS 13.0, *) {
            return traitCollection.userInterfaceStyle == .dark
        } else {
            // Fallback on earlier versions
            return false
        }
    }
    
    func statusStyle() -> UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
}
