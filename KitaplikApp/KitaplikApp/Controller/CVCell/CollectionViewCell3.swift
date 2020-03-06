//
//  CollectionViewCell3.swift
//  Bookhub
//
//  Created by Burak Yılmaz on 6.03.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import UIKit

class CollectionViewCell3: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        image.layer.cornerRadius = 30
    }
}
