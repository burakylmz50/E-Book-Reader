//
//  OpenEpubController.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 22.01.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore
import Foundation
import FolioReaderKit
import CoreData

class OpenEpubController: UIViewController,WKScriptMessageHandler, WKNavigationDelegate {
    
   
    
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var epubURL: UITextView!
    @IBOutlet weak var kitapResim: UIImageView!
    @IBOutlet weak var startReadingBttn: UIButton!
    @IBAction func startReadingBttn(_ sender: Any) {
        doubleTapped(abc: kitapURLepub)
    }
    
    @IBAction func kitapligaEkle(_ sender: Any) {
        //         self.performSegue(withIdentifier: "goToLibrary", sender: nil)
        let tabBar = tabBarController as! TabBarController
        tabBar.myVariable = kitapImg
        tabBar.kitapLink = kitapURLepub
        
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //        // Get the destination  view controller in destVC.
    //        // Pass the selected object to the new view controller.
    //        if segue.identifier == "goToLibrary" {
    //            if let destVC = segue.destination as? MyLibraryController {
    //                destVC.soba = "ali"
    //            }
    //        }
    //    }
    
    var kitapAdi : String = ""
    var kitapURL : String = ""
    var kitapURLepub : String = ""
    var kitapImg : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        epubURL.text = kitapAdi
        setupWebView(gulay: abbbc)
        // Do any additional setup after loading the view.
        kitapResimAcma()
        kitapResim.layer.cornerRadius = 15
    }
    func kitapResimAcma(){
        let url = URL(string: kitapImg)
        URLSession.shared.dataTask(with: url!){
            (data,response,error) in
            if error != nil{
                print("error")
                return
            }
            DispatchQueue.main.async {
                self.kitapResim.image = UIImage(data : data!)
            }
        }.resume()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Start loading")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("🐸")
        webView.evaluateJavaScript("returnJSON()", completionHandler: nil)
    }
    func setupWebView(gulay:String) {
        //        let Url2 = URL(string: gulay.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        //        let Url3 = Url2?.absoluteString
        //        let searchURL :String = "https://www.pdfdrive.com/search?q="
        //        let sonURL = searchURL + Url3!
        let sonURL2 = URL(string: kitapURL)
        
        
        if let url = sonURL2 {
            let webConfiguration = WKWebViewConfiguration()
            let userController = WKUserContentController()
            
            let javaScript = JavaScriptProvider().scriptInjection
            
            let userScript =  WKUserScript(source: javaScript,
                                           injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
                                           forMainFrameOnly: false)
            
            //Add listeners in JavaScript Injection
            userController.addUserScript(userScript)
            userController.add(self, name: callback)
            
            webConfiguration.userContentController = userController
            
            webView = WKWebView(frame: webView.frame, configuration: webConfiguration)
            
            //
            webView.navigationDelegate = self
            //
            webView.load(URLRequest(url: url))
            //            view = UIView()
            ////            view.backgroundColor = UIColor.clear
            //
            //            webView.addSubview(webView)
            sil22 = webView
        }
    }
    let searchURL = URL(string: "https://www.pdfdrive.com/search?q=")
    let callback = "json"
    var abbbc : String = ""
    var sil22 = UIView()
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == callback {
            print("🍎")
            let a : String = message.body as! String
            print(a)
            print(message.body)
            kitapURLepub = a
            
            //  fonksoyin kitap aç
            if let objectString = message.body as? String {
                guard let data = objectString.data(using: .utf8) else { return }
                
                //                do {
                //                    list = try JSONDecoder().decode([House].self, from: data)
                //
                //                    for i in 0..<list.count{
                //                        print(list[i].imgsrc)
                //                        print("-----------------------")
                //                    }
                ////                    detailsTableView.reloadData()
                //                }
                //                catch { print(error) }
                //                do {
                //                    let jsonObject = try JSONSerialization.jsonObject(with: data)
                //                    if let jsonDictonary = jsonObject as? [Dictionary<String, Any>] {"
                //                        //Straigt forward parsing.
                //                        //Hm callback did not called. Lets look into that.
                //                        // fixed :)
                //                        //Its very raw straight implementation and there is plenty ways to do it in well fashion.
                //                        //Keep in mind, that we are here looking for json array. Lets say we get only one object in json, so this wont work.
                //
                //                        print(jsonDictonary[0]["imgsrc"] ?? "anything")
                //                    } else {
                //                        print("json parse edilemedi.")
                //                    }
                //                } catch let error {
                //                    print(error)
                //                }
            }
            
            //            jsonToString(json: message.body as AnyObject, completionHandler: {
            //                response in print(response)
            //            })
            //how many years have you been writing ios? 10 yea Senior Developer :)
        }
    }
    func showSavedEpub( fileName:String) {
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains(fileName) {
                        // its your file! do what you want with it!
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
        let config = FolioReaderConfig()
        config.shouldHideNavigationOnTap = true
        config.scrollDirection = .horizontal
        let folioReader = FolioReader()
        folioReader.presentReader(parentViewController: self, withEpubPath: bookPath, andConfig: config)
        self.removeSpinner()
    }
    
    
    //    Download
    func doubleTapped(abc : String) {
        self.showSpinner(onView: self.view)
        
        //        let abcd = String(abc) // indexPath.item ' ı kitapApi'sinin sonuna ekliyorum. URL olarak veriyorum.
        if let fileUrl = URL(string: abc) {
            
            //    self.indicatorView?.startAnimating()
            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(fileUrl.lastPathComponent+".epub")
            print(destinationUrl)
            
            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                //       self.indicatorView?.stopAnimating()
                print("The file already exists at path")
                // if the file doesn't exist
                DispatchQueue.main.async {
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




class JavaScriptProvider {
    let scriptInjection = """
       
        function returnJSON() {
            var filejsonObj = [];

            eval($($("div.ebook-buttons > div > a:nth-child(2)").first()).attr("onclick"));
            $($("#convert").first()).trigger("click");

            var setInterval1 = setInterval(getConvertResult, 3000);
            var convertResult = "";

            function getConvertResult() {


                convertResult = $("#convertResult > a").attr("href");

                if (convertResult == null || convertResult == "") {

                } else {
                
                clearInterval(setInterval1);
                window.webkit.messageHandlers.json.postMessage(convertResult);
                }
            }
            
        };

       """
}
