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
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var bigTitle: UILabel!
    @IBOutlet weak var firstTitle: UILabel!
    @IBOutlet weak var secondTitle: UILabel!
    
    var staticBookURL : [String] = ["https://www.pdfdrive.com/download?id=10172273&h=84f0f3490acb0a861ce0cf97be914eed&ext=epub","https://www.pdfdrive.com/download?id=58864799&h=c55ee8a467a370dd11fcf9dcec21f426&ext=epub","https://www.pdfdrive.com/download?id=60737077&h=1e8a4333c7514960d4ce2695b0c54266&ext=epub","https://www.pdfdrive.com/download?id=162371455&h=fc9f78f5b025419c32a82c946c4176d2&ext=epub","https://www.pdfdrive.com/download?id=14796117&h=9679311a2840c4f3f7a8f4addaae687c&ext=epub","https://www.pdfdrive.com/download?id=39563520&h=d26773018a95a8d230aab48b021d3682&ext=epub","https://www.pdfdrive.com/download?id=60375000&h=3ec6e7155bd469509b5d59796a2b5a38&ext=epub","https://www.pdfdrive.com/download?id=185720921&h=9137a8382fdea149de12875e6843d017&ext=epub","https://www.pdfdrive.com/download?id=60737120&h=c348e12c7f8e071873c6ddbf55bd51d5&ext=epub","https://www.pdfdrive.com/download?id=60737124&h=a56b33f1bd86346ffc92366a7a460d7d&ext=epub","https://www.pdfdrive.com/download?id=60737129&h=7973d78e5006c3382040e49d7e1aff63&ext=epub","https://www.pdfdrive.com/download?id=60737125&h=c8caba172b2243925f561e4d89f89a3e&ext=epub","https://www.pdfdrive.com/download?id=60365102&h=2b93da0326a25cad517d66affc0dce1a&ext=epub","https://www.pdfdrive.com/download?id=60375019&h=a992a526aa0b57856baaf6631dd806f6&ext=epub","https://www.pdfdrive.com/download?id=60363043&h=b915e7c337fe32e5ea2cfdbf8bfb27b0&ext=epub","https://www.pdfdrive.com/download?id=60374996&h=7ebce24f9c1c02c9333c41d15dc63f3f&ext=epub","https://www.pdfdrive.com/download?id=60374999&h=9db78554fb2fa0ba02b20920b510fc8a&ext=epub","https://www.pdfdrive.com/download?id=61378067&h=12cbb3386b15984384744ac9012d844b&ext=epub","https://www.pdfdrive.com/download?id=60365112&h=ff45a822a44b139c7ea19a5c199bd064&ext=epub","https://www.pdfdrive.com/download?id=60365106&h=ae89fda34936b29c7b68d46889b958bb&ext=epub","https://www.pdfdrive.com/download?id=145171874&h=6121ad21a4368a9c7b0c6949abb191e1&ext=epub","https://www.pdfdrive.com/download?id=17483815&h=b0a10aedf2e79a66b60b1da6b0caf502&ext=epub","https://www.pdfdrive.com/download?id=60375005&h=3175beb370cab7f9625d26316605e0f6&ext=epub","https://www.pdfdrive.com/download?id=60737084&h=b51749bcda9fd74c78831d85c557b3f0&ext=epub","https://www.pdfdrive.com/download?id=145171531&h=b687857ad36a443998192f8ee852aa8d&ext=epub","https://www.pdfdrive.com/download?id=145171678&h=36947ad827022d244350e14578e5b484&ext=epub"]
    var staticBookURL2 : [String] = ["https://www.pdfdrive.com/download?id=60375019&h=a992a526aa0b57856baaf6631dd806f6&ext=epub","https://www.pdfdrive.com/download?id=60363043&h=b915e7c337fe32e5ea2cfdbf8bfb27b0&ext=epub","https://www.pdfdrive.com/download?id=60374996&h=7ebce24f9c1c02c9333c41d15dc63f3f&ext=epub","https://www.pdfdrive.com/download?id=60374999&h=9db78554fb2fa0ba02b20920b510fc8a&ext=epub","https://www.pdfdrive.com/download?id=61378067&h=12cbb3386b15984384744ac9012d844b&ext=epub","https://www.pdfdrive.com/download?id=60365112&h=ff45a822a44b139c7ea19a5c199bd064&ext=epub","https://www.pdfdrive.com/download?id=60365106&h=ae89fda34936b29c7b68d46889b958bb&ext=epub","https://www.pdfdrive.com/download?id=145171874&h=6121ad21a4368a9c7b0c6949abb191e1&ext=epub","https://www.pdfdrive.com/download?id=17483815&h=b0a10aedf2e79a66b60b1da6b0caf502&ext=epub","https://www.pdfdrive.com/download?id=60375005&h=3175beb370cab7f9625d26316605e0f6&ext=epub","https://www.pdfdrive.com/download?id=60737084&h=b51749bcda9fd74c78831d85c557b3f0&ext=epub","https://www.pdfdrive.com/download?id=145171531&h=b687857ad36a443998192f8ee852aa8d&ext=epub","https://www.pdfdrive.com/download?id=145171678&h=36947ad827022d244350e14578e5b484&ext=epub"]
    var staticBookImage : [String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13"]
    var staticBookImage2 : [String] = ["14","15","16","17","18","19","20","21","22","23","24","25","26"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == cView2){
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
        let cell = cView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.resimImg.image = UIImage(named: staticBookImage[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == cView2){
            doubleTapped(abc: staticBookURL2[indexPath.row], abc2: indexPath.row)
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
        
        topView.layer.cornerRadius = 30
        
        //ScrollView Hide Bar
        myScrollView.showsVerticalScrollIndicator = false
        cView.showsHorizontalScrollIndicator = false
        cView2.showsHorizontalScrollIndicator = false
        
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
