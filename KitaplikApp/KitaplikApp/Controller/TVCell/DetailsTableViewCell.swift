//
//  DetailsTableViewCell.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 20.01.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var kitapResim: UIImageView!
    @IBOutlet weak var kitapAdi: UITextView!
    @IBOutlet weak var DownloadCount: UILabel!
    @IBOutlet weak var pageCount: UILabel!
    @IBOutlet weak var bookSize: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
        kitapAdi.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
        kitapAdi.textColor = UIColor.white
         DownloadCount.textColor = UIColor.white
         pageCount.textColor = UIColor.white
        bookSize.textColor = UIColor.white
        kitapResim.layer.cornerRadius = 15
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
