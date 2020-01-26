//
//  SearchBarController.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 25.12.2019.
//  Copyright © 2019 Burak Yılmaz. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore
import Foundation

class SearchBarController: UIViewController,UITableViewDelegate,UITableViewDataSource,WKScriptMessageHandler, WKNavigationDelegate ,UITextFieldDelegate{
    var detailVC = DetailsController()
    var deneme = [String]()
    var labelContent : String = ""
    var searchBarView = SearchBarView()
    var jsContext = JSContext()
    var list = [House]()
    let webURL = URL(string: "https://www.pdfdrive.com/orhan-pamuk-books.html")
    let callback = "json"
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBarTF: UITextField!
    @IBOutlet weak var webView: WKWebView!
    @IBAction func searchBarTFClear(_ sender: Any) {
        view.endEditing(true)
        searchBarTF.text?.removeAll()
        deneme.removeAll()
        searchTableView.reloadData()
    }
    
    var sil = UIView()
    
    //Editing Changed
    @IBAction func searchBarTF(_ sender: Any) {
        searchBarView.search(ilkArananKelime: searchBarTF.text!, completionHandler: {
            response in
            DispatchQueue.main.async {
                self.deneme = response
                self.searchTableView.reloadData()
            }
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deneme.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchBarTableViewCell
        
        cell.searchBarLabel.text = deneme[indexPath.row].capitalized
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.cellForRow(at: indexPath) as! SearchBarTableViewCell
        labelContent = deneme[indexPath.row]
        print(labelContent)
        view.endEditing(true)
        self.performSegue(withIdentifier: "showDetails", sender: indexPath)
        //        detailVC.abbbc = labelContent
        //       bunlara tıklıyorum yeni bir sayfa açsın. ve açtığı sayfaya o satırda yazanı yazsın anladın mı anladım yeni sayfaın controlleri hangisi
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the destination  view controller in destVC.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetails" {
            if let destVC = segue.destination as? DetailsController {
                destVC.abbbc = labelContent
            }
        }
    }
    
    func addLeftImageTo(txtfield:UITextField , andImage img:UIImage){
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 20))
        leftImageView.image = img
        searchBarTF.leftView = leftImageView
        searchBarTF.leftViewMode = .always
        
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
        searchTableView.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
        searchTableView.separatorColor = UIColor.clear
        
        searchBarTF.backgroundColor = UIColor(red:0.22, green:0.24, blue:0.29, alpha:0.5)
        searchBarTF.attributedPlaceholder = NSAttributedString(string: " Search for books,tutorials and authors", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red:0.50, green:0.54, blue:0.59, alpha:1.0)])
        searchBarTF.textColor = UIColor.white
        searchBarTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        searchBarTF.layer.cornerRadius = 15
        let searchIcon = UIImage(named: "search_icon")
        addLeftImageTo(txtfield: searchBarTF, andImage: searchIcon!)
        
        //        klavye açılsın default
        searchBarTF.becomeFirstResponder()
        
        //Table view kaydırıldığında klavyeyi kapat
        searchTableView.keyboardDismissMode = .onDrag
        
        //Otomatik düzeltme kapatma
        searchBarTF.autocorrectionType = .no
        
        //Textfield ilk karakteri büyük olması için.
        searchBarTF.autocapitalizationType = .words
        
        searchBarTF.delegate = self
        
        
        super.viewDidLoad()
        setupWebView()
        //        view.isHidden = true
        
    }
    
    //Boşluğa tıklayınca klavye kapanması
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Start loading")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("🐸")
        webView.evaluateJavaScript("returnJSON()", completionHandler: nil)
    }
    func setupWebView() {
        if let url = webURL {
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
            sil = webView
        }
    }
    struct House : Codable {
        var header: String = ""
        var hit: String? = "NULL"
        var imgsrc: String = ""
        var lang: String = ""
        var pagecount: String? = "NULL"
        var size: String = ""
        var year: String = ""
    }
    func jsonToString(json: AnyObject,completionHandler:@escaping (String) -> ()){
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString!) // <-- here is ur string
            
        } catch let myJSONError {
            print(myJSONError)
        }
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == callback {
            print("🍎")
            
            //            print(message.body)
            
            if let objectString = message.body as? String {
                guard let data = objectString.data(using: .utf8) else { return }
                
                
                do {
                    list = try JSONDecoder().decode([House].self, from: data)
                    
                    for i in 0..<list.count{
                        print(list[i].imgsrc)
                    }
                }
                catch { print(error) }
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
    class JavaScriptProvider {
        let scriptInjection = """
       
        function returnJSON() {
            var filejsonObj = [];

            $.each($("div.files-new div.row"), function () {
                var file_header = $(this).find("div.file-right h2").text();
                var file_pagecount = $(this).find("div.file-info .fi-pagecount").text();
                var file_year = $(this).find("div.file-info .fi-year").text();
                var file_size = $(this).find("div.file-info .fi-size").text();
                var file_hit = $(this).find("div.file-info .fi-hit").text();
                var file_lang = $(this).find("div.file-info .fi-lang").text();
                var file_imgsrc = $(location).attr("origin") + $(this).find("div.file-right a").attr("href");

                var file_jsonObj = {
                    header: file_header,
                    pagecount: file_pagecount,
                    year: file_year,
                    size: file_size,
                    hit: file_hit,
                    lang: file_lang,
                    imgsrc: file_imgsrc
                };
                filejsonObj.push(file_jsonObj);
            })
            
            var fileJsonObjStr = JSON.stringify(filejsonObj);
            window.webkit.messageHandlers.json.postMessage(fileJsonObjStr);

        };

       """
    }
    
}
