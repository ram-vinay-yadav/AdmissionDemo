//
//  A24SubjectDetails.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 25/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//

import UIKit

protocol A24SubjectDetailsPresenterProtocol: class {
    var viewC: A24SubjectDetailsViewProtocol? { get set }
    var interactor: A24SubjectDetailsInteractorProtocol? { get set }
    var router: A24SubjectDetailsRouterProtocol? { get set }
    
    func setUpDesign(view: A24SubjectDetailsViewController)
    func didApperSetUpDesign(view: A24SubjectDetailsViewController)
    func viewWillAppear(view: A24SubjectDetailsViewController)
}

protocol A24SubjectDetailsViewProtocol: class {
    func showResponseSuccess(message: String)
    func showResponseError(message:String)
}

protocol A24SubjectDetailsInteractorProtocol: class {
    var presenter:A24SubjectDetailsInteractorPresenterProtocol? { get set }
}

protocol A24SubjectDetailsRouterProtocol: class {
    static func setViewController(details: [String:Any]?) -> A24SubjectDetailsViewController
    func pushViewController(view: A24SubjectDetailsViewController)
}

protocol A24SubjectDetailsInteractorPresenterProtocol: class {
    func showResponseSuccess(message: String)
    func showResponseError(message:String)
}
