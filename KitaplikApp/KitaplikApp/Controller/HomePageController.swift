//
//  HomePageController.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 11.12.2019.
//  Copyright © 2019 Burak Yılmaz. All rights reserved.
//

import UIKit

class HomePageController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var cView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = cView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.resimImg.image = UIImage(named: "laCasaDePapel")
        return cell
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

}
