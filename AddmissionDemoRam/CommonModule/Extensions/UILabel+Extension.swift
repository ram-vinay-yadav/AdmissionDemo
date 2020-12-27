//
//  UILabel+Extension.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 26/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//

import UIKit

extension UILabel {
    func addAttributedStringWith(attributedString:String,
                                 with attributedColor:UIColor,
                                 font attributedFont:UIFont,
                                 mainString:String,
                                 with textColor:UIColor,
                                 font mainFont:UIFont) {
        
        let range = (mainString as NSString).range(of: attributedString)
        
        let attribute = NSMutableAttributedString(string: mainString, attributes: [NSAttributedString.Key.foregroundColor : textColor, NSAttributedString.Key.font : mainFont])
        
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: attributedColor,  range: range)
        
        attribute.addAttribute(NSAttributedString.Key.font, value: attributedFont, range: range)
        
        self.attributedText = attribute
        
    }
    
}
