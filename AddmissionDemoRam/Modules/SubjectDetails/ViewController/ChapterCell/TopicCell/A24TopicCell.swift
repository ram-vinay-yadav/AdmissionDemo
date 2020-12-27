//
//  A24TopicCell.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 26/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//

import UIKit

class A24TopicCell: UITableViewCell {

    @IBOutlet weak var topicNameLabel: UILabel!
    @IBOutlet weak var topicDetailsLabel: UILabel!
    @IBOutlet weak var outerCircleView: UIView!
    @IBOutlet weak var innerCircleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpDesign()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
 
    private func setUpDesign() {
        self.outerCircleView.setRoundCorner(cornerRadius: self.outerCircleView.bounds.height/2)
        self.innerCircleView.setRoundCorner(cornerRadius: self.innerCircleView.bounds.height/2)
    }
    
}
