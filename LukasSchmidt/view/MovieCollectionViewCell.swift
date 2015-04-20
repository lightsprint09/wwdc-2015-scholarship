//
//  MovieCollectionViewCell.swift
//  LukasSchmidt
//
//  Created by Lukas Schmidt on 20.04.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    func setMovie(dict:NSDictionary) {
        titleLabel.text = (dict.valueForKey("title") as! String)
        let duration = dict.valueForKey("duration") as! Int
        durationLabel.text = "\(duration) min"
    }
    
    func setImageData(data:NSData) {
        coverImageView.image = UIImage(data: data);
    }
}
