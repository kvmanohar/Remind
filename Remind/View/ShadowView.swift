//
//  ShadowView.swift
//  Remind
//
//  Created by Manohar Kurapati on 15/06/2018.
//  Copyright © 2018 Manosoft. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowView: UIView {
    override func awakeFromNib() {
        layer.shadowPath = CGPath(rect: layer.bounds, transform: nil)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
        layer.cornerRadius = 5
    }
}
