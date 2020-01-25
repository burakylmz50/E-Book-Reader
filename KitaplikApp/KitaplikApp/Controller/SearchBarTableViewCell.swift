//
//  SearchBarTableViewCell.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 25.12.2019.
//  Copyright © 2019 Burak Yılmaz. All rights reserved.
//

import UIKit

class SearchBarTableViewCell: UITableViewCell {

    @IBOutlet weak var searchBarLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1)
        searchBarLabel.clipsToBounds = true
        self.clipsToBounds = true
        searchBarLabel.layer.cornerRadius = 5
      //  searchBarLabel.backgroundColor = UIColor.darkGray
        
        searchBarLabel.layer.borderColor = UIColor.darkGray.cgColor
        searchBarLabel.layer.borderWidth = 1.0
        
        searchBarLabel.textColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}


//
//
////
////  SearchBarController.swift
////  KitaplikApp
////
////  Created by Burak Yılmaz on 25.12.2019.
////  Copyright © 2019 Burak Yılmaz. All rights reserved.
////
//
//import UIKit
//import WebKit
//import JavaScriptCore
//import Foundation
//
//class SearchBarController: UIViewController,UITableViewDelegate,UITableViewDataSource,WKScriptMessageHandler, WKNavigationDelegate {
//
//
//    var deneme = [String]()
//    var searchBarView = SearchBarView()
//    var jsContext = JSContext()
//    let webURL = URL(string: "https://www.pdfdrive.com/orhan-pamuk-books.html")
//    let callback = "json"
//    @IBOutlet weak var searchTableView: UITableView!
//    @IBOutlet weak var searchBarTF: UITextField!
//
//    @IBOutlet weak var webView: WKWebView!
//
//
//    //Editing Changed
//    @IBAction func searchBarTF(_ sender: Any) {
//        searchBarView.search(ilkArananKelime: searchBarTF.text!, completionHandler: {
//            response in
//            DispatchQueue.main.async {
//                self.deneme = response
//                self.searchTableView.reloadData()
//            }
//        })
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return deneme.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = searchTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchBarTableViewCell
//        cell.searchBarLabel.text = deneme[indexPath.row]
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        _ = tableView.cellForRow(at: indexPath) as! SearchBarTableViewCell
//        let labelContent = deneme[indexPath.row]
//        print(labelContent)
//    }
//
//    override func viewDidLoad() {
//        view.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
//        super.viewDidLoad()
//        setupWebView()
//    }
//    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//        print("Start loading")
//    }
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        print("🐸")
//        webView.evaluateJavaScript("returnJSON()", completionHandler: nil)
//    }
//    func setupWebView() {
//        if let url = webURL {
//            let webConfiguration = WKWebViewConfiguration()
//            let userController = WKUserContentController()
//
//            let javaScript = JavaScriptProvider().scriptInjection
//
//            let userScript =  WKUserScript(source: javaScript,
//                                           injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
//                                           forMainFrameOnly: false)
//
//            //Add listeners in JavaScript Injection
//            userController.addUserScript(userScript)
//            userController.add(self, name: callback)
//
//            webConfiguration.userContentController = userController
//
//            webView = WKWebView(frame: view.frame, configuration: webConfiguration)
//
//            webView.navigationDelegate = self
//
//            webView.load(URLRequest(url: url))
//            view = webView
//        }
//    }
//    class HousePrice {
//        var header: String = ""
//        var hit: String? = ""
//        var imgsrc: String = ""
//        var lang: String = ""
//        var pagecount: String? = ""
//        var size: String = ""
//        var year: String = ""
//
//    }
//    func jsonToString(json: AnyObject,completionHandler:@escaping (String) -> ()){
//         do {
//             let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
//             let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
//             print(convertedString!) // <-- here is ur string
//
//         } catch let myJSONError {
//             print(myJSONError)
//         }
//
//     }
//    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        if message.name == callback {
//            print("🍎")
////            print(message.body)
//            jsonToString(json: message.body as AnyObject, completionHandler: {
//                response in print(response)
//            })
//
//    }
//
//}
//
//class JavaScriptProvider {
//    let scriptInjection = """
//
//       function setState() {
//          window.webkit.messageHandlers.json.postMessage("");
//       };
//
//        function returnJSON() {
//            var filejsonObj = [];
//
//            $.each($("div.files-new div.row"), function () {
//                var file_header = $(this).find("div.file-right h2").text();
//                var file_pagecount = $(this).find("div.file-info .fi-pagecount").text();
//                var file_year = $(this).find("div.file-info .fi-year").text();
//                var file_size = $(this).find("div.file-info .fi-size").text();
//                var file_hit = $(this).find("div.file-info .fi-hit").text();
//                var file_lang = $(this).find("div.file-info .fi-lang").text();
//                var file_imgsrc = $(location).attr("origin") + $(this).find("div.file-right a").attr("href");
//
//                var file_jsonObj = {
//                    header: file_header,
//                    pagecount: file_pagecount,
//                    year: file_year,
//                    size: file_size,
//                    hit: file_hit,
//                    lang: file_lang,
//                    imgsrc: file_imgsrc
//                };
//                filejsonObj.push(file_jsonObj);
//            })
//
//            window.webkit.messageHandlers.json.postMessage(filejsonObj);
//
//        };
//
//       """
//}
//
//}
//
//struct ilkJsonConvert : Codable {
//let header : String?
//let imgsrc : String?
//let hit : String?
//let lang : String?
//let size : String?
//let year : String?
//let pagecount : String?
//}




// tadas yaptı bunu
//
////
////  SearchBarController.swift
////  KitaplikApp
////
////  Created by Burak Yılmaz on 25.12.2019.
////  Copyright © 2019 Burak Yılmaz. All rights reserved.
////
//
//import UIKit
//import WebKit
//import JavaScriptCore
//import Foundation
//
//class SearchBarController: UIViewController,UITableViewDelegate,UITableViewDataSource,WKScriptMessageHandler, WKNavigationDelegate {
//
//
//    var deneme = [String]()
//    var searchBarView = SearchBarView()
//    var jsContext = JSContext()
//    let webURL = URL(string: "https://www.pdfdrive.com/orhan-pamuk-books.html")
//    let callback = "json"
//    @IBOutlet weak var searchTableView: UITableView!
//    @IBOutlet weak var searchBarTF: UITextField!
//
//    @IBOutlet weak var webView: WKWebView!
//
//
//    //Editing Changed
//    @IBAction func searchBarTF(_ sender: Any) {
//        searchBarView.search(ilkArananKelime: searchBarTF.text!, completionHandler: {
//            response in
//            DispatchQueue.main.async {
//                self.deneme = response
//                self.searchTableView.reloadData()
//            }
//        })
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return deneme.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = searchTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchBarTableViewCell
//        cell.searchBarLabel.text = deneme[indexPath.row]
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        _ = tableView.cellForRow(at: indexPath) as! SearchBarTableViewCell
//        let labelContent = deneme[indexPath.row]
//        print(labelContent)
//    }
//
//    override func viewDidLoad() {
//        view.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
//        super.viewDidLoad()
//        setupWebView()
//    }
//    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//        print("Start loading")
//    }
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        print("🐸")
//        webView.evaluateJavaScript("returnJSON()", completionHandler: nil)
//    }
//    func setupWebView() {
//        if let url = webURL {
//            let webConfiguration = WKWebViewConfiguration()
//            let userController = WKUserContentController()
//
//            let javaScript = JavaScriptProvider().scriptInjection
//
//            let userScript =  WKUserScript(source: javaScript,
//                                           injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
//                                           forMainFrameOnly: false)
//
//            //Add listeners in JavaScript Injection
//            userController.addUserScript(userScript)
//            userController.add(self, name: callback)
//
//            webConfiguration.userContentController = userController
//
//            webView = WKWebView(frame: view.frame, configuration: webConfiguration)
//
//            webView.navigationDelegate = self
//
//            webView.load(URLRequest(url: url))
//            view = webView
//        }
//    }
//    class HousePrice {
//        var header: String = ""
//        var hit: String? = ""
//        var imgsrc: String = ""
//        var lang: String = ""
//        var pagecount: String? = ""
//        var size: String = ""
//        var year: String = ""
//
//    }
//    func jsonToString(json: AnyObject,completionHandler:@escaping (String) -> ()){
//         do {
//             let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
//             let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
//             print(convertedString!) // <-- here is ur string
//
//         } catch let myJSONError {
//             print(myJSONError)
//         }
//
//     }
//    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        if message.name == callback {
//            print("🍎")
////            print(message.body)
//
//            if let objectString = message.body as? String {
//                guard let data = objectString.data(using: .utf8) else { return }
//                do {
//                    let jsonObject = try JSONSerialization.jsonObject(with: data)
//                    if let jsonDictonary = jsonObject as? [Dictionary<String, Any>] {
//                        //Straigt forward parsing.
//                        //Hm callback did not called. Lets look into that.
//                        // fixed :)
//                        //Its very raw straight implementation and there is plenty ways to do it in well fashion.
//                        //Keep in mind, that we are here looking for json array. Lets say we get only one object in json, so this wont work.
//
//                        print(jsonDictonary[0]["imgsrc"] ?? "anything")
//                    } else {
//                        if let jsonObject = jsonObject as? Dictionary<String, Any> {
//                            print(jsonObject["imgsrc"])
//                            //Like that.
//                            // I do not fully understand one minutes
//                            // okey I understood you right now
//                            // if I have any other questions i will reach you okay?
//                            //Ofcourse but please reach Erdim and say we fixed that. I would like not to for for free all week. ;)
//                            //And do you use git for source countrol? Then it would be easier to fix. I would just checkout the master or branch
////                            and would look into the code
//                            // github. But it'll be public otherwise you have paid account. yes See you later thenk you. bye.
//                        }
//                    }
//                } catch let error {
//                    print(error)
//                }
//            }
//
////            jsonToString(json: message.body as AnyObject, completionHandler: {
////                response in print(response)
////            })
//            //how many years have you been writing ios? 10 yea Senior Developer :)
//    }
//
//}
//    class JavaScriptProvider {
//    let scriptInjection = """
//
//        function returnJSON() {
//            var filejsonObj = [];
//
//            $.each($("div.files-new div.row"), function () {
//                var file_header = $(this).find("div.file-right h2").text();
//                var file_pagecount = $(this).find("div.file-info .fi-pagecount").text();
//                var file_year = $(this).find("div.file-info .fi-year").text();
//                var file_size = $(this).find("div.file-info .fi-size").text();
//                var file_hit = $(this).find("div.file-info .fi-hit").text();
//                var file_lang = $(this).find("div.file-info .fi-lang").text();
//                var file_imgsrc = $(location).attr("origin") + $(this).find("div.file-right a").attr("href");
//
//                var file_jsonObj = {
//                    header: file_header,
//                    pagecount: file_pagecount,
//                    year: file_year,
//                    size: file_size,
//                    hit: file_hit,
//                    lang: file_lang,
//                    imgsrc: file_imgsrc
//                };
//                filejsonObj.push(file_jsonObj);
//            })
//
//            var fileJsonObjStr = JSON.stringify(filejsonObj);
//            window.webkit.messageHandlers.json.postMessage(fileJsonObjStr);
//
//        };
//
//       """
//    }
//
//}
//
//struct ilkJsonConvert : Codable {
//let header : String?
//let imgsrc : String?
//let hit : String?
//let lang : String?
//let size : String?
//let year : String?
//let pagecount : String?
//}
//
