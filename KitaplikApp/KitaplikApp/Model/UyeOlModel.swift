//
//  UyeOlModel.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 6.12.2019.
//  Copyright © 2019 Burak Yılmaz. All rights reserved.
//

import Foundation
struct Data2 : Codable {
    let id : Int?
    let ad : String?
    let soyad : String?
    let sifre : String?
    let email : String?
    let grupId : String?
    let premium : String?
    let kurumsalAd : String?
    let token : String?
}
struct UyeOlModel : Codable {
    let data : Data2?
    let isSuccess : Bool?
    let resultCode : String?
    let messages : [String]?
    let formMessage : String?
    let exception : String?
}
