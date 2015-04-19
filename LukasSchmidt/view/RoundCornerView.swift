//
//  RoundCornerView.swift
//  LukasSchmidt
//
//  Created by Lukas Schmidt on 19.04.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class RoundCornerView: UIView {

    override func awakeFromNib() {
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
