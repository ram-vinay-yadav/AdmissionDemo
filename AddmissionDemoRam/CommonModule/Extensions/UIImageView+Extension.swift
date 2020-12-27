//
//  UIImageView+Extension.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 26/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//

import UIKit

extension UIImage {
    public static func imageWithRenderingModeAlwaysTemplate(named: String) -> UIImage? {
        let image = UIImage(named: named)?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        return imageView.image
    }
}
