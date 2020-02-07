//
//  MyLibraryTableViewCell.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 29.01.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import UIKit

class MyLibraryTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bookImage.layer.cornerRadius = 15
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
