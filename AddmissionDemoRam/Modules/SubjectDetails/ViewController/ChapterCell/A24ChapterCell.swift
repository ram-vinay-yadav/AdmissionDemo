//
//  A24ChapterCell.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 25/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//

import UIKit

class A24ChapterCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var chapterView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var statusContainerView: UIView!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var connectorView: UIView!
    @IBOutlet weak var chapterContainerView: UIView!
    @IBOutlet weak var topicTableView: UITableView!
    
    var chapterDetails:A24ChaptersModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpDesign()
    }

    private func setUpDesign() {
        self.chapterView.setRoundCornerWithBorder(cornerRadius:self.chapterView.bounds.height/2, borderColor: TGColors.whiteWithOpcity, borderWidth: 1.0)
        self.containerView.setRoundCorner(cornerRadius: self.containerView.bounds.height/2)
        
        self.topicTableView.tableFooterView = UIView()
        self.topicTableView.estimatedRowHeight = 90
        self.topicTableView.rowHeight = 90
        self.topicTableView.register(A24TopicCell.nib, forCellReuseIdentifier: A24TopicCell.defaultReuseIdentifier)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    internal func cellSetupWith(data:A24ChaptersModel) {
        self.chapterDetails = data
        if data.isLocked {
            self.statusImageView.image = UIImage(named: "lock")
            self.chapterContainerView.isHidden = true
        } else if data.isOpen {
            self.statusImageView.image = UIImage(named: "dropdownIcon")
            self.chapterContainerView.isHidden = false
        } else {
            self.statusImageView.image = UIImage(named: "rightArrow")
            self.chapterContainerView.isHidden = true
        }
        
        self.topicTableView.dataSource = self
        self.topicTableView.delegate = self
        self.topicTableView.reloadData()
        
        self.titleLabel.text = data.chapter
        self.detailsLabel.text = data.details
        
        let nubmerOfItemsString = "\(data.chapter) - \(data.topic)"
        self.titleLabel.addAttributedStringWith(attributedString: "- \(data.topic)",
            with: .darkGray,
            font: self.titleLabel.font,
            mainString: nubmerOfItemsString,
            with: TGColors.lightBlue,
            font: self.titleLabel.font)
    }
    
}
