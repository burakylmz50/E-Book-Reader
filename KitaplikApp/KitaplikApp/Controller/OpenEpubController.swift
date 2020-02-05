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
    @IBAction func addToMyLibrary(_ sender: Any) {
        //        doubleTapped(abc: kitapURLepub)
        let tabBar = tabBarController as! TabBarController
        tabBar.myVariable = kitapImg
        tabBar.kitapLink = kitapURLepub
    }
    @IBOutlet weak var addToMyLibrary: UIButton!
    
    
    
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
        padding()
        let alert = UIAlertController(title: "İnformation", message: "If the book is available in our system, the button will be active.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
                addToMyLibrary.isEnabled = false
        epubURL.text = kitapAdi
        setupWebView(gulay: abbbc)
        kitapResimAcma()
        kitapResim.layer.cornerRadius = 15
    }
    func padding(){
         view.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
        
        
        addToMyLibrary.setTitleColor(UIColor(red:0.65, green:0.69, blue:0.73, alpha:1.0), for:.normal)
        addToMyLibrary.layer.cornerRadius = 15
        
        addToMyLibrary.layer.borderWidth = 1.0
        addToMyLibrary.layer.borderColor = UIColor(red:0.59, green:0.59, blue:0.59, alpha:1.0).cgColor
        
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
                        addToMyLibrary.isEnabled = true
           
            addToMyLibrary.backgroundColor = UIColor(red:0.01, green:0.44, blue:0.98, alpha:1.0)
            addToMyLibrary.setTitleColor(UIColor.white, for: .normal)
            addToMyLibrary.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            addToMyLibrary.layer.borderWidth = 0
            
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
