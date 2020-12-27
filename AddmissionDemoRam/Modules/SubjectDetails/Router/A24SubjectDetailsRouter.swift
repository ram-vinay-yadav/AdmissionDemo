//
//  A24SubjectDetails.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 25/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//

import UIKit

class A24SubjectDetailsRouter: A24SubjectDetailsRouterProtocol {
    
    static func setViewController(details: [String:Any]?) -> A24SubjectDetailsViewController {

        let viewC = mainStoryboard.instantiateViewController(withIdentifier: "A24SubjectDetailsViewController") as! A24SubjectDetailsViewController

        let presenter   : A24SubjectDetailsPresenterProtocol & A24SubjectDetailsInteractorPresenterProtocol = A24SubjectDetailsPresenter()
        let interactor  : A24SubjectDetailsInteractorProtocol = A24SubjectDetailsInteractor()
        let router      :  A24SubjectDetailsRouterProtocol = A24SubjectDetailsRouter()
        
        presenter.viewC = viewC
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        viewC.viewPresenter = presenter

        return viewC
        
    }


    func pushViewController(view: A24SubjectDetailsViewController) {
        
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name:"Main", bundle: Bundle.main)
    }
}
