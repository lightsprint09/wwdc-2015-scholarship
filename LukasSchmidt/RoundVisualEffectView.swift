//
//  RoundVisualEffectView.swift
//  LukasSchmidt
//
//  Created by Lukas Schmidt on 25.04.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class RoundVisualEffectView: UIVisualEffectView {

    override func awakeFromNib() {
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }


}
