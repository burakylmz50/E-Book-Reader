//
//  CollectionViewCell2.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 7.02.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import UIKit

class CollectionViewCell2: UICollectionViewCell {
    @IBOutlet weak var bookImage: UIImageView!
    
    override func awakeFromNib() {
        bookImage.layer.cornerRadius = 30
    }
}
