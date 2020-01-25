//
//  SearchBarView.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 25.12.2019.
//  Copyright © 2019 Burak Yılmaz. All rights reserved.
//

import Foundation

class SearchBarView{
    var ilkArananKelime : String = ""
    var sevval : [String] = []
    
    func search(ilkArananKelime :String,completionHandler:@escaping ([String]) -> ()){
        let urlString = URL(string: "https://tr.pdfdrive.com/search/complete?query=" + ilkArananKelime)
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if data != nil {
                        _ = String(decoding: data!, as: UTF8.self)
                        
                        do {
                            let decoder = JSONDecoder()
                            let gitData = try decoder.decode(searchFirst.self, from: data!)
                            let (suggestionsCount) : Int = gitData.suggestions!.count
                            if(suggestionsCount>3){
                                for index in 0...(suggestionsCount-1){
                                    self.sevval.append(gitData.suggestions![index])
                                }
                            }
                            else{
                                print("gelen data yok az harf girilmiş")
                            }
                            
                            completionHandler(self.sevval)
                        }
                        catch{
                            print("Json error:", error)
                        }
                        
                    }
                }
            }
            task.resume()
        }
        self.sevval.removeAll()
    }
    

    
    
    
    
    
    
}

