//
//  A24SubjectDetails.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 25/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//

import UIKit

class A24SubjectDetailsPresenter: A24SubjectDetailsPresenterProtocol {
    
    var viewC: A24SubjectDetailsViewProtocol?
    var interactor: A24SubjectDetailsInteractorProtocol?
    var router: A24SubjectDetailsRouterProtocol?
    
    func setUpDesign(view: A24SubjectDetailsViewController) {
        
        // Start with an initial value for the content size
        view.previousScrollViewHeight = view.detailsTableView.contentSize.height

        view.backButton.setImage(UIImage.imageWithRenderingModeAlwaysTemplate(named: "back"), for: .normal)
        view.ebookArrowImageView.image = UIImage.imageWithRenderingModeAlwaysTemplate(named: "forward")
        view.ebookArrowImageView.tintColor = TGColors.defaultWhite
            
        view.backButton.tintColor = TGColors.defaultWhite
        self.progressViews(view: view)
        view.detailsTableView.tableFooterView = UIView()
        view.detailsTableView.keyboardDismissMode = .onDrag
        view.detailsTableView.estimatedRowHeight = 70
        view.detailsTableView.rowHeight = UITableView.automaticDimension
        view.detailsTableView.register(A24ChapterCell.nib, forCellReuseIdentifier: A24ChapterCell.defaultReuseIdentifier)
        
        view.refreshControl.tintColor = TGColors.defaultBlack
        view.refreshControl.attributedTitle = NSAttributedString(string: "")
        //view.detailsTableView.addSubview(view.refreshControl)
        
        view.courseStatusContainerView.setRoundCorner(cornerRadius: 20)
        view.courseStatusContainerView.applyShadow(color: .darkGray, offSet: CGSize(width: 0, height: 0))
        
        view.eBookContainerView.isUserInteractionEnabled = true
        let tapOnStatusView = UITapGestureRecognizer(target: view, action: #selector(view.handleEbookViewTap(_:)))
        view.eBookContainerView.addGestureRecognizer(tapOnStatusView)
        
        if DEVICE_SIZE.width > 320 {
            view.widthConstant.constant = 315
            view.firstSpaceConstant.constant = 30
            view.secondSpaceConstant.constant = 30
        }
        
        view.chapterList = [
            A24ChaptersModel(chapter: "Chapter 1", topic: "3 Topics", topicList: [A24TopicModel(title: "test", detail: "test details", complete: 5)], details: "Punctuation, capitalisation and...", isLocked: true, isOpen: false),
            A24ChaptersModel(chapter: "Chapter 2", topic: "2 Topics", topicList: [A24TopicModel(title: "", detail: "", complete: 5)], details: "Punctuation, capitalisation and...", isLocked: true, isOpen: false),
            A24ChaptersModel(chapter: "Chapter 3", topic: "4 Topics", topicList: [A24TopicModel(title: "Topic 1", detail: "Multiply a two-digit number by a three-digit number: complete the missing steps", complete: 5),A24TopicModel(title: "Topic 2", detail: "Multiply a two-digit number by a three-digit number: complete the missing steps", complete: 5),A24TopicModel(title: "Topic 3", detail: "Multiply a two-digit number by a three-digit number: complete the missing steps", complete: 5),A24TopicModel(title: "Topic 4", detail: "Multiply a two-digit number by a three-digit number: complete the missing steps", complete: 5)], details: "Punctuation, capitalisation and...", isLocked: false, isOpen: false),
            A24ChaptersModel(chapter: "Chapter 4", topic: "1 Topic", topicList: [A24TopicModel(title: "", detail: "", complete: 5)], details: "Punctuation, capitalisation and...", isLocked: true, isOpen: false),
            A24ChaptersModel(chapter: "Chapter 5", topic: "3 Topics", topicList: [A24TopicModel(title: "", detail: "", complete: 5)], details: "Punctuation, capitalisation and...", isLocked: true, isOpen: false),
            A24ChaptersModel(chapter: "Chapter 6", topic: "2 Topics", topicList: [A24TopicModel(title: "", detail: "", complete: 5)], details: "Punctuation, capitalisation and...", isLocked: true, isOpen: false),
            A24ChaptersModel(chapter: "Chapter 7", topic: "5 Topics", topicList: [A24TopicModel(title: "", detail: "", complete: 5)], details: "Punctuation, capitalisation and...", isLocked: true, isOpen: false),
            A24ChaptersModel(chapter: "Chapter 8", topic: "3 Topics", topicList: [A24TopicModel(title: "", detail: "", complete: 5)], details: "Punctuation, capitalisation and...", isLocked: true, isOpen: false),
            A24ChaptersModel(chapter: "Chapter 9", topic: "5 Topics", topicList: [A24TopicModel(title: "", detail: "", complete: 5)], details: "Punctuation, capitalisation and...", isLocked: true, isOpen: false),
            A24ChaptersModel(chapter: "Chapter 10", topic: "5 Topics", topicList: [A24TopicModel(title: "", detail: "", complete: 5)], details: "Punctuation, capitalisation and...", isLocked: true, isOpen: false)
        ]

    }
    
    func didApperSetUpDesign(view: A24SubjectDetailsViewController) {
        view.archView.setRoundCorner(corners: [.topLeft, .topRight], radius: 40)
        view.bookArchView.setRoundCorner(corners: [.topLeft, .topRight], radius: 40)
        
        view.eBookContainerView.setRoundCorner(corners: [.topLeft, .topRight], radius: 10)
        view.eBookContainerView.setRoundCorner(corners: [.bottomLeft, .bottomRight], radius: 40)
        
        view.eBookContainerView.roundCorners(topLeft: 10, topRight: 10, bottomLeft: 30, bottomRight: 30, boarderWidth: 4, borderColor: TGColors.defaultWhite)
        

        
    }
    
    func viewWillAppear(view: A24SubjectDetailsViewController) {
        view.headerHeightConstraint.constant = view.maxHeaderHeight
        view.updateHeader()
    }
    
    
    func progressViews(view: A24SubjectDetailsViewController) {
        
        view.coinProgressView.trackColor = TGColors.whiteWithOpcity
        view.coinProgressView.startAngle = 90
        view.coinProgressView.progressThickness = 0.4
        view.coinProgressView.trackThickness = 0.4
        view.coinProgressView.clockwise = true
        view.coinProgressView.gradientRotateSpeed = 1
        view.coinProgressView.roundedCorners = true
        view.coinProgressView.glowMode = .forward
        view.coinProgressView.glowAmount = 0.5
        view.coinProgressView.set(colors: .red)
        
        view.coinProgressView.animate(fromAngle: 0, toAngle: 120, duration: 0.5) { completed in
            if completed {
                debugPrint("animation stopped, completed")
            } else {
                debugPrint("animation stopped, was interrupted")
            }
        }
        
        view.completedProgressView.trackColor = TGColors.whiteWithOpcity
        view.completedProgressView.startAngle = 90
        view.completedProgressView.progressThickness = 0.4
        view.completedProgressView.trackThickness = 0.4
        view.completedProgressView.clockwise = true
        view.completedProgressView.gradientRotateSpeed = 1
        view.completedProgressView.roundedCorners = true
        view.completedProgressView.glowMode = .forward
        view.completedProgressView.glowAmount = 0.5
        view.completedProgressView.set(colors: TGColors.lightBlue)
        
        view.completedProgressView.animate(fromAngle: 0, toAngle: 180, duration: 0.5) { completed in
            if completed {
                debugPrint("animation stopped, completed")
            } else {
                debugPrint("animation stopped, was interrupted")
            }
        }
        
        view.timeSpentProgressView.trackColor = TGColors.whiteWithOpcity
        view.timeSpentProgressView.startAngle = 90
        view.timeSpentProgressView.progressThickness = 0.4
        view.timeSpentProgressView.trackThickness = 0.4
        view.timeSpentProgressView.clockwise = true
        view.timeSpentProgressView.gradientRotateSpeed = 1
        view.timeSpentProgressView.roundedCorners = true
        view.timeSpentProgressView.glowMode = .forward
        view.timeSpentProgressView.glowAmount = 0.5
        view.timeSpentProgressView.set(colors: TGColors.defaultGreen)
        
        view.timeSpentProgressView.animate(fromAngle: 0, toAngle: 270, duration: 0.5) { completed in
            if completed {
                debugPrint("animation stopped, completed")
            } else {
                debugPrint("animation stopped, was interrupted")
            }
        }
    }
}

extension A24SubjectDetailsPresenter: A24SubjectDetailsInteractorPresenterProtocol {
    func showResponseSuccess(message: String) {
        viewC?.showResponseSuccess(message: message)
    }
    
    func showResponseError(message: String) {
        viewC?.showResponseError(message: message)
    }
    
}
