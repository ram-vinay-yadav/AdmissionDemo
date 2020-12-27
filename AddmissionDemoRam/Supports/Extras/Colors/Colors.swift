//
//  Colors.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 25/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//


import UIKit

//MARK:- Color

struct TGColors {
    static let lightRed = UIColor(displayP3Red: 107.0/255.0, green: 157.0/255.0, blue: 108.0/255.0, alpha: 1.0)
    static let shadowColor  = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
    static let lightWhite = UIColor(displayP3Red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
    static let borderGrey = UIColor(red: 183.0/255.0, green: 183.0/255.0, blue: 183.0/255.0, alpha: 1.0)
}

extension TGColors {
    static let defaultRed: UIColor = {
        if #available(iOS 11.0, *) {
            return UIColor(named: "rvRedColor")!
        } else {
            return UIColor.red
        }
    }()
    
    static let defaultWhite: UIColor = {
        if #available(iOS 11.0, *) {
            return UIColor(named: "rvWhiteColor")!
        } else {
            return UIColor.white
        }
    }()
    
    static let defaultBlack: UIColor = {
        if #available(iOS 11.0, *) {
            return UIColor(named: "rvBlackColor")!
        } else {
            return UIColor.black
        }
    }()
    
    static let defaultGreen: UIColor = {
        if #available(iOS 11.0, *) {
            return UIColor(named: "rvGreenColor")!
        } else {
            return UIColor.green
        }
    }()
    
    static let defaultYellow: UIColor = {
        if #available(iOS 11.0, *) {
            return UIColor(named: "rvYellowColor")!
        } else {
            return UIColor.yellow
        }
    }()
    
    static let alwaysWhite: UIColor = {
        if #available(iOS 11.0, *) {
            return UIColor(named: "rvAlwaysWhiteColor")!
        } else {
            return UIColor.white
        }
    }()
    
    static let alwaysBlack: UIColor = {
        if #available(iOS 11.0, *) {
            return UIColor(named: "rvAlwaysBlackColor")!
        } else {
            return UIColor.white
        }
    }()
    
    static let clear: UIColor = {
            return UIColor.clear
    }()
    
    static let dairyBackground: UIColor = {
        if #available(iOS 11.0, *) {
            return UIColor(named: "rvDairyBgColor")!
        } else {
            return UIColor(red: 0.0/255.0, green: 189.0/255.0, blue: 207.0/255.0, alpha: 1.0)
        }
    }()
    
    static let whiteWithOpcity: UIColor = {
        if #available(iOS 11.0, *) {
            return UIColor(named: "rvWhiteWithOpcity")!
        } else {
            return UIColor(red: 231.0/255.0, green: 232.0/255.0, blue: 233.0/255.0, alpha: 0.7)
        }
    }()
    
    static let blackWithOpcity: UIColor = {
        if #available(iOS 11.0, *) {
            return UIColor(named: "rvblackWithOpcity")!
        } else {
            return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        }
    }()
    
    static let lightBlue: UIColor = {
        if #available(iOS 11.0, *) {
            return UIColor(named: "rvLightBlueColor")!
        } else {
            return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        }
    }()
    
    static let clearLightGray: UIColor = {
        if #available(iOS 11.0, *) {
            return UIColor(named: "rvClearLightGray")!
        } else {
            return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        }
    }()
    
    static let placeHolderOnBlur: UIColor = {
        if #available(iOS 11.0, *) {
            return UIColor(named: "rvPlaceHolderGray")!
        } else {
            return UIColor(red: 160.0/255.0, green: 160.0/255.0, blue: 160.0/255.0, alpha: 1.0)
        }
    }()
    
}

