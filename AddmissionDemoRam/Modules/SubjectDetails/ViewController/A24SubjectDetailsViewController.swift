//
//  A24SubjectDetails.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 25/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//

import UIKit

class A24SubjectDetailsViewController: A24BaseViewController {
    
    //MARK:- IBOutlets here
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var archView: UIView!
    @IBOutlet weak var courseStatusContainerView: UIView!
    @IBOutlet weak var coinProgressView: RVCircularProgress!
    @IBOutlet weak var completedProgressView: RVCircularProgress!
    @IBOutlet weak var timeSpentProgressView: RVCircularProgress!
    @IBOutlet weak var chapterContainerLabel: UILabel!
    @IBOutlet weak var chpterLineImageView: UIImageView!
    @IBOutlet weak var bookArchView: UIView!
    @IBOutlet weak var bookTypeImageView: UIImageView!
    @IBOutlet weak var eBookContainerView: UIView!
    @IBOutlet weak var ebookArrowImageView: UIImageView!
    @IBOutlet weak var firstSpaceConstant: NSLayoutConstraint!
    @IBOutlet weak var secondSpaceConstant: NSLayoutConstraint!
    @IBOutlet weak var widthConstant: NSLayoutConstraint!
    
    //MARK:- variables declerations
    weak var viewPresenter: A24SubjectDetailsPresenterProtocol?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(A24SubjectDetailsViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = TGColors.defaultBlack
        return refreshControl
    }()
    internal var chapterList:[A24ChaptersModel] = []
    internal let maxHeaderHeight: CGFloat = 340
    internal let minHeaderHeight: CGFloat = 170
    internal var previousScrollOffset: CGFloat = 0
    internal var previousScrollViewHeight: CGFloat = 0
    internal var isShowAnimation:Bool = true
    
    
    //MARK:- controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewPresenter?.viewWillAppear(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewPresenter?.didApperSetUpDesign(view: self)
    }
    
    //MARK:- common ui design setup here
    internal func setUpDesign() {
        viewPresenter?.setUpDesign(view: self)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
    }
    
    @objc func handleEbookViewTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.showMessage("Thanks for your request, this will updated soon.", type: .success)
    }
    
}

//MARK:- Add more funcunality here
extension A24SubjectDetailsViewController : A24SubjectDetailsViewProtocol {
    func showResponseSuccess(message: String) {
        debugPrint("VC success response : ", message)
    }
    
    func showResponseError(message: String) {
         debugPrint("VC error response : ", message)
    }
}




