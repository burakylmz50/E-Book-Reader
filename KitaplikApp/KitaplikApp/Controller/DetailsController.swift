//
//  DetailsController.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 18.01.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore
import Foundation




//search bar story board un içindeki son sayfaya yine bir table view ekle headerları içine yazdır. Ve o adrese tıklat. Diğer java Script fonk. Çalıştır


class DetailsController: UIViewController,WKScriptMessageHandler, WKNavigationDelegate,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailsTableViewCell
        //        burak(a: "asdasd")
        cell.kitapAdi.text = list[indexPath.row].header
        cell.DownloadCount.text = "· " + list[indexPath.row].hit!
        cell.bookSize.text = "· " + list[indexPath.row].size
        cell.pageCount.text = "· " + list[indexPath.row].pagecount!
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        let url = URL(string: list[indexPath.row].imgurl)
                   URLSession.shared.dataTask(with: url!){
                       (data,response,error) in
                       if error != nil{
                           print("error")
                           return
                       }
                       DispatchQueue.main.async {
                           cell.kitapResim.image = UIImage(data : data!)
                       }
                   }.resume()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.cellForRow(at: indexPath) as! DetailsTableViewCell
        labelContent = list[indexPath.row].imgsrc
        kitapImage = list[indexPath.row].imgurl
        kitapAdi = list[indexPath.row].header.capitalized
        
        print(labelContent)
        self.performSegue(withIdentifier: "openEpubURL", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the destination  view controller in destVC.
        // Pass the selected object to the new view controller.
        if segue.identifier == "openEpubURL" {
            if let destVC = segue.destination as? OpenEpubController {
                destVC.kitapURL = labelContent
                destVC.kitapImg = kitapImage
                destVC.kitapAdi = kitapAdi
            }
        }
    }
    var labelContent : String = ""
     var kitapImage : String = ""
      var kitapAdi : String = ""
    var deneme2 = [String]()
    var deneme3 = [String]()
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var detailsTableView: UITableView!
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == callback {
            self.removeSpinner()
            print("🍎")
            
            //            print(message.body)
            
            if let objectString = message.body as? String {
                guard let data = objectString.data(using: .utf8) else { return }
                
                
                do {
                    list = try JSONDecoder().decode([House].self, from: data)
                    
                    for i in 0..<list.count{
                        print(list[i].imgsrc)
                        print(list[i].header)
                        print(list[i].imgurl)
                        print(list[i].hit!)
                        print(list[i].lang)
                        print(list[i].pagecount!)
                        print(list[i].size)
                        print("-----------------------")
                    }
                    detailsTableView.reloadData()
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
    
    var abbbc : String = ""
    let searchURL = URL(string: "https://www.pdfdrive.com/search?q=")
    let callback = "json"
    var sil22 = UIView()
    var list = [House]()
    func burak(a:String){
        
        //Gelen String'i URLEncode Yapıyor
        let Url2 = URL(string: a.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        print(Url2)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
          view.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
        detailsTableView.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
        self.navigationController?.navigationBar.topItem?.title = "Search Books"
        print("sevval aşırı çok güzel :)")
        
        burak(a: abbbc)
        setupWebView(gulay: abbbc)
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.showSpinner(onView: view)
        print("Start loading")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("🐸")
        webView.evaluateJavaScript("returnJSON()", completionHandler: nil)
    }
    func setupWebView(gulay:String) {
        let Url2 = URL(string: gulay.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        let Url3 = Url2?.absoluteString
        let searchURL :String = "https://www.pdfdrive.com/search?q="
        let sonURL = searchURL + Url3!
        let sonURL2 = URL(string: sonURL)
        
        
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
    struct House : Codable {
        var header: String = ""
        var hit: String? = ""
        var imgsrc: String = ""
        var lang: String = ""
        var pagecount: String? = ""
        var size: String = ""
        var year: String = ""
        var imgurl: String = ""
        
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
                var file_imgurl = $(this).find("div.file-left img").attr("data-original");

                var file_jsonObj = {
                    header: file_header,
                    pagecount: file_pagecount,
                    year: file_year,
                    size: file_size,
                    hit: file_hit,
                    lang: file_lang,
                    imgsrc: file_imgsrc,
                    imgurl:file_imgurl
                };
                filejsonObj.push(file_jsonObj);
            })

            var fileJsonObjStr = JSON.stringify(filejsonObj);
            window.webkit.messageHandlers.json.postMessage(fileJsonObjStr);

        };

       """
    }
}


//class JavaScriptProvider {
//        let scriptInjection = """
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
//
//            setTimeout(function(){
//               window.webkit.messageHandlers.json.postMessage(fileJsonObjStr);
//            }, 3000);
//
//        };
//
//       """
//    }
//}
