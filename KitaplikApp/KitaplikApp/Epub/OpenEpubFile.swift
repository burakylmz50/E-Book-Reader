//
//  File.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 26.11.2019.
//  Copyright © 2019 Burak Yılmaz. All rights reserved.
//

import Foundation
import UIKit
import FolioReaderKit

//let kitapApi:String = "http://e-kitaplik.net/api/kitap/epub/"
//
//class OpenEpubFile:UIViewController{
//    func showSavedEpub( fileName:String , myController :UIViewController) {
//        if #available(iOS 10.0, *) {
//            do {
//                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
//                for url in contents {
//                    if url.description.contains(fileName) {
//                        // its your file! do what you want with it!
//                        self.open(bookPath: url.path,myCont: myController)
//                        break
//                    }
//                }
//            } catch {
//                print("could not locate epub file !!!!!!!")
//            }
//        }
//    }
//    func open(bookPath:String,myCont:UIViewController) {
//        let config = FolioReaderConfig()
//        config.shouldHideNavigationOnTap = true
//        config.scrollDirection = .horizontal
//        let folioReader = FolioReader()
//        folioReader.presentReader(parentViewController: myCont, withEpubPath: bookPath, andConfig: config)
//        self.removeSpinner()
//    }
//
//
//    //    Download
//    func doubleTapped(abc : Int,myController:UIViewController) {
//        self.showSpinner(onView: self.view)
//
//        let abcd = String(abc) // indexPath.item ' ı kitapApi'sinin sonuna ekliyorum. URL olarak veriyorum.
//        if let fileUrl = URL(string: kitapApi + abcd) {
//
//            //    self.indicatorView?.startAnimating()
//            // then lets create your document folder url
//            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//            // lets create your destination file url
//            let destinationUrl = documentsDirectoryURL.appendingPathComponent(fileUrl.lastPathComponent+".epub")
//            print(destinationUrl)
//
//            // to check if it exists before downloading it
//            if FileManager.default.fileExists(atPath: destinationUrl.path) {
//                //       self.indicatorView?.stopAnimating()
//                print("The file already exists at path")
//                // if the file doesn't exist
//                DispatchQueue.main.async {
//                    self.showSavedEpub(fileName:destinationUrl.lastPathComponent,myController: myController)
//                }
//            } else {
//
//                // you can use NSURLSession.sharedSession to download the data asynchronously
//                URLSession.shared.downloadTask(with: fileUrl) { location, response, error in
//                    guard let location = location, error == nil else { return }
//                    do {
//                        // after downloading your file you need to move it to your destination url
//                        try FileManager.default.moveItem(at: location, to: destinationUrl)
//                        print("DOWNLOAD COMPLETED: File moved to documents folder")
//
//                        DispatchQueue.main.async {
//                            //              self.indicatorView?.stopAnimating()
//                            self.removeSpinner()
//                            self.showSavedEpub(fileName:destinationUrl.lastPathComponent,myController: myController)
//                        }
//
//                    } catch {
//                        print(error)
//                    }
//                }.resume()
//            }
//        }
//    }
//}
