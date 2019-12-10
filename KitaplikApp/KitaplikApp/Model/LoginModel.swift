//
//  LoginModel.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 6.12.2019.
//  Copyright © 2019 Burak Yılmaz. All rights reserved.
//

import Foundation

struct LoginModel: Codable {
    let isSuccess : Bool?
    let resultCode : String?
    let exception : String?
    let messages : [String]?
    let data : Data?
}
struct Data : Codable {
    let id : Int?
    let ad : String?
    let soyad : String?
    let sifre : String?
    let email : String?
    let grupId : String?
    let premium : String?
    let kurumsalAd : String?
    let aciklama : String?
    let telefon : String?
    let deleted : String?
    let createdOn : String?
    let createdBy : Int?
    let changedOn : String?
    let changedBy : String?
    let onaylandi : String?
    let token : String?
}
