//
//  CollectionViewCell.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 11.12.2019.
//  Copyright © 2019 Burak Yılmaz. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var resimImg: UIImageView!
    
    override func awakeFromNib() {
        resimImg.layer.cornerRadius = 30
    }
}
