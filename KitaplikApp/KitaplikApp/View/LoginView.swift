//
//  LoginView.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 6.12.2019.
//  Copyright © 2019 Burak Yılmaz. All rights reserved.
//

import Foundation

class LoginView{
    
    var epostaAdresi : String = ""
    var parola : String = ""
    var errorMessage : String = ""
    func userLogin(epostaAdresi:String,parola:String,completionHandler:@escaping (Bool) -> ()){
        
        let parameters = ["email": epostaAdresi as Any, "sifre": parola as Any] as [String : Any]
        let url = URL(string: "http://e-kitaplik.net/api/kullanici/gettoken")! //change the url
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                if (try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) != nil {
                    // print(json)
                    // handle json...
                    let decoder = JSONDecoder()
                    let gitData = try decoder.decode(LoginModel.self, from: data)
                    if(gitData.isSuccess == true){
                        print("Giriş başarılı")
                        completionHandler(true)
                        //tokenDonus = gitData.token!
                        DispatchQueue.main.async(){
                            //self.performSegue(withIdentifier: "loginToHome", sender: self)
                        }
                    }
                    else{
                        self.errorMessage = gitData.messages![0]
                        completionHandler(false)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
}
