//
//  HomePageController.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 11.12.2019.
//  Copyright © 2019 Burak Yılmaz. All rights reserved.
//

import UIKit
import FolioReaderKit

class HomePageController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var cView: UICollectionView!
    @IBOutlet weak var cView2: UICollectionView!
    @IBOutlet weak var cView3: UICollectionView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var bigTitle: UILabel!
    @IBOutlet weak var firstTitle: UILabel!
    @IBOutlet weak var secondTitle: UILabel!
    
    var staticBookURL : [String] = ["https://www.pdfdrive.com/download?id=10172273&h=84f0f3490acb0a861ce0cf97be914eed&ext=epub","https://www.pdfdrive.com/download?id=58864799&h=c55ee8a467a370dd11fcf9dcec21f426&ext=epub","https://www.pdfdrive.com/download?id=60737077&h=1e8a4333c7514960d4ce2695b0c54266&ext=epub","https://www.pdfdrive.com/download?id=162371455&h=fc9f78f5b025419c32a82c946c4176d2&ext=epub","https://www.pdfdrive.com/download?id=14796117&h=9679311a2840c4f3f7a8f4addaae687c&ext=epub","https://www.pdfdrive.com/download?id=39563520&h=d26773018a95a8d230aab48b021d3682&ext=epub","https://www.pdfdrive.com/download?id=60375000&h=3ec6e7155bd469509b5d59796a2b5a38&ext=epub","https://www.pdfdrive.com/download?id=185720921&h=9137a8382fdea149de12875e6843d017&ext=epub","https://www.pdfdrive.com/download?id=60737120&h=c348e12c7f8e071873c6ddbf55bd51d5&ext=epub","https://www.pdfdrive.com/download?id=60737124&h=a56b33f1bd86346ffc92366a7a460d7d&ext=epub","https://www.pdfdrive.com/download?id=60737129&h=7973d78e5006c3382040e49d7e1aff63&ext=epub","https://www.pdfdrive.com/download?id=60737125&h=c8caba172b2243925f561e4d89f89a3e&ext=epub","https://www.pdfdrive.com/download?id=60365102&h=2b93da0326a25cad517d66affc0dce1a&ext=epub","https://www.pdfdrive.com/download?id=60375019&h=a992a526aa0b57856baaf6631dd806f6&ext=epub","https://www.pdfdrive.com/download?id=60363043&h=b915e7c337fe32e5ea2cfdbf8bfb27b0&ext=epub","https://www.pdfdrive.com/download?id=60374996&h=7ebce24f9c1c02c9333c41d15dc63f3f&ext=epub","https://www.pdfdrive.com/download?id=60374999&h=9db78554fb2fa0ba02b20920b510fc8a&ext=epub","https://www.pdfdrive.com/download?id=61378067&h=12cbb3386b15984384744ac9012d844b&ext=epub","https://www.pdfdrive.com/download?id=60365112&h=ff45a822a44b139c7ea19a5c199bd064&ext=epub","https://www.pdfdrive.com/download?id=60365106&h=ae89fda34936b29c7b68d46889b958bb&ext=epub","https://www.pdfdrive.com/download?id=145171874&h=6121ad21a4368a9c7b0c6949abb191e1&ext=epub","https://www.pdfdrive.com/download?id=17483815&h=b0a10aedf2e79a66b60b1da6b0caf502&ext=epub","https://www.pdfdrive.com/download?id=60375005&h=3175beb370cab7f9625d26316605e0f6&ext=epub","https://www.pdfdrive.com/download?id=60737084&h=b51749bcda9fd74c78831d85c557b3f0&ext=epub","https://www.pdfdrive.com/download?id=145171531&h=b687857ad36a443998192f8ee852aa8d&ext=epub","https://www.pdfdrive.com/download?id=145171678&h=36947ad827022d244350e14578e5b484&ext=epub"]
    var staticBookURL2 : [String] = ["https://www.pdfdrive.com/download?id=60375019&h=a992a526aa0b57856baaf6631dd806f6&ext=epub","https://www.pdfdrive.com/download?id=60363043&h=b915e7c337fe32e5ea2cfdbf8bfb27b0&ext=epub","https://www.pdfdrive.com/download?id=60374996&h=7ebce24f9c1c02c9333c41d15dc63f3f&ext=epub","https://www.pdfdrive.com/download?id=60374999&h=9db78554fb2fa0ba02b20920b510fc8a&ext=epub","https://www.pdfdrive.com/download?id=61378067&h=12cbb3386b15984384744ac9012d844b&ext=epub","https://www.pdfdrive.com/download?id=60365112&h=ff45a822a44b139c7ea19a5c199bd064&ext=epub","https://www.pdfdrive.com/download?id=60365106&h=ae89fda34936b29c7b68d46889b958bb&ext=epub","https://www.pdfdrive.com/download?id=145171874&h=6121ad21a4368a9c7b0c6949abb191e1&ext=epub","https://www.pdfdrive.com/download?id=17483815&h=b0a10aedf2e79a66b60b1da6b0caf502&ext=epub","https://www.pdfdrive.com/download?id=60375005&h=3175beb370cab7f9625d26316605e0f6&ext=epub","https://www.pdfdrive.com/download?id=60737084&h=b51749bcda9fd74c78831d85c557b3f0&ext=epub","https://www.pdfdrive.com/download?id=145171531&h=b687857ad36a443998192f8ee852aa8d&ext=epub","https://www.pdfdrive.com/download?id=145171678&h=36947ad827022d244350e14578e5b484&ext=epub"]
    var staticBookURL3 : [String] = ["https://www.pdfdrive.com/download?id=176072086&h=a07f845738ebf5835c9425680ad2f4b9&ext=epub","https://www.pdfdrive.com/download?id=167737235&h=b082dfdb54ad9279e68622e0d1b5bb1e&ext=epub","https://www.pdfdrive.com/download?id=165226090&h=f4dcf7de33576b243d203adf1ed1ebcb&ext=epub","https://www.pdfdrive.com/download?id=158525823&h=0d79e2dc1b97bf123bb6cf4dd0763d8a&ext=epub","https://www.pdfdrive.com/download?id=156643180&h=c8e920ab6affa8155cfdea7a1fe5d827&ext=epub","https://www.pdfdrive.com/download?id=175917911&h=6b272c5af3909b3acb7966e13dcd9f82&ext=epub","https://www.pdfdrive.com/download?id=157120454&h=245a8d49c671b48c32d03509e6d0be77&ext=epub","https://www.pdfdrive.com/download?id=157615501&h=869579b9c6affcdc6a4e303dfc58b0f5&ext=epub","https://www.pdfdrive.com/download?id=184019340&h=4ef5cd93ed7fd8700c87a291cf3d6262&ext=epub","https://www.pdfdrive.com/download?id=157162412&h=6e0233826b9749ad045a94a51922388f&ext=epub","https://www.pdfdrive.com/download?id=33491873&h=59783b3143bd25f4aff68e7b81925749&ext=epub","https://www.pdfdrive.com/download?id=176216972&h=3c4118d4f7975a46f76078dddc670093&ext=epub","https://www.pdfdrive.com/download?id=196793731&h=b6e66cbfcd6a4a7c0ed01f194ef2b15c&ext=epub","https://www.pdfdrive.com/download?id=195033308&h=2f567c85feb1e7d7f8ea4d4119b272eb&ext=epub","https://www.pdfdrive.com/download?id=156920415&h=2dee6bb9a4ddd17607b5b8bfb4c493c7&ext=epub","https://www.pdfdrive.com/download?id=184745240&h=2ed688c8d0e17a7cc4ff787049c0ce08&ext=epub","https://www.pdfdrive.com/download?id=176309911&h=8e3b4c90621dff61124d58c31de8e707&ext=epub"]
    var staticBookImage : [String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13"]
    var staticBookImage2 : [String] = ["14","15","16","17","18","19","20","21","22","23","24","25","26"]
    var staticBookImage3 : [String] = ["27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == cView2){
            return staticBookImage2.count
        }
        if(collectionView == cView3){
                   return staticBookImage2.count
               }
        return staticBookImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == cView2){
            let cell = cView2.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell2
            cell.bookImage.image = UIImage(named: staticBookImage2[indexPath.row])
            return cell
        }
        if(collectionView == cView3){
                   let cell = cView3.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell3
                   cell.image.image = UIImage(named: staticBookImage3[indexPath.row])
                   return cell
               }
        let cell = cView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.resimImg.image = UIImage(named: staticBookImage[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == cView2){
            doubleTapped(abc: staticBookURL2[indexPath.row], abc2: indexPath.row)
        }
            if(collectionView == cView3){
                doubleTapped(abc: staticBookURL3[indexPath.row], abc2: indexPath.row+40)
            }
        else{
            doubleTapped(abc: staticBookURL[indexPath.row], abc2: indexPath.row+20)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        padding()
    }
    
    func padding(){
        view.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
        secondView.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
        topView.backgroundColor = UIColor(red:0.13, green:0.16, blue:0.24, alpha:1.0)
        cView.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
        cView2.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
         cView3.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
        
        topView.layer.cornerRadius = 30
        
        //ScrollView Hide Bar
        myScrollView.showsVerticalScrollIndicator = false
        cView.showsHorizontalScrollIndicator = false
        cView2.showsHorizontalScrollIndicator = false
         cView3.showsHorizontalScrollIndicator = false
        
        bigTitle.textColor = UIColor(red:0.91, green:0.92, blue:0.92, alpha:1.0)
        firstTitle.textColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
        secondTitle.textColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
    }
    func showSavedEpub( fileName:String) {
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains(fileName) {
                        // its your file! do what you want with it!
                        self.removeSpinner()
                        self.open(bookPath: url.path)
                        break
                    }
                }
            } catch {
                print("could not locate epub file !!!!!!!")
            }
        }
    }
    func open(bookPath:String) {
        self.removeSpinner()
        let config = FolioReaderConfig()
        config.shouldHideNavigationOnTap = true
        config.scrollDirection = .horizontal
        let folioReader = FolioReader()
        folioReader.presentReader(parentViewController: self, withEpubPath: bookPath, andConfig: config)
        
    }
    
    
    //    Download
    func doubleTapped(abc : String,abc2 : Int) {
        self.showSpinner(onView: self.view)
        
        let abcd = String(abc2)
        if let fileUrl = URL(string: abc) {
            
            //    self.indicatorView?.startAnimating()
            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(fileUrl.lastPathComponent+abcd+".epub")
            print(destinationUrl)
            
            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                //       self.indicatorView?.stopAnimating()
                self.removeSpinner()
                print("The file already exists at path")
                // if the file doesn't exist
                DispatchQueue.main.async {
                    self.removeSpinner()
                    self.showSavedEpub(fileName:destinationUrl.lastPathComponent)
                }
            } else {
                
                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: fileUrl) { location, response, error in
                    guard let location = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationUrl)
                        print("DOWNLOAD COMPLETED: File moved to documents folder")
                        
                        DispatchQueue.main.async {
                            //              self.indicatorView?.stopAnimating()
                            self.showSavedEpub(fileName:destinationUrl.lastPathComponent)
                        }
                        
                    } catch {
                        print(error)
                    }
                }.resume()
            }
        }
    }
}
