//
//  SifremiUnuttumController.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 9.12.2019.
//  Copyright © 2019 Burak Yılmaz. All rights reserved.
//

import UIKit

class SifremiUnuttumController: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var sifremiUnuttumLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var aciklamaTW: UITextView!
    @IBOutlet weak var emailAdresiTF: UITextField!
    @IBOutlet weak var gonderButton: UIButton!
    @IBAction func gonderButton(_ sender: Any) {
    }
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //Editing Changed
    @IBAction func emailAdresiTF(_ sender: Any) {
        emailAdresiTF.textColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        emailAdresiTF.backgroundColor = UIColor(red:0.22, green:0.24, blue:0.29, alpha:1.0)
        emailAdresiTF.font =  UIFont.systemFont(ofSize: 16.0, weight: .semibold)
         gonderButton.backgroundColor = UIColor(red:0.01, green:0.44, blue:0.98, alpha:1.0)
        gonderButton.setTitleColor(UIColor.white, for: .normal)
        gonderButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        gonderButton.layer.borderWidth = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
        padding()
    }
    
    func padding(){
        sifremiUnuttumLabel.textColor = UIColor.white
        aciklamaTW.textColor = UIColor(red:0.65, green:0.69, blue:0.73, alpha:1.0)
        aciklamaTW.backgroundColor = UIColor.clear
        gonderButton.setTitleColor(UIColor(red:0.65, green:0.69, blue:0.73, alpha:1.0), for:.normal)
        
        emailAdresiTF.delegate = self
        
        emailAdresiTF.backgroundColor = UIColor(red:0.15, green:0.16, blue:0.20, alpha:1.0)
        
        emailAdresiTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        
        emailAdresiTF.layer.cornerRadius = 15
        gonderButton.layer.cornerRadius = 15
        
        emailAdresiTF.attributedPlaceholder = NSAttributedString(string: "E-posta adresi", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red:0.50, green:0.54, blue:0.59, alpha:1.0)])
        
        gonderButton.layer.borderWidth = 1.0
        gonderButton.layer.borderColor = UIColor(red:0.59, green:0.59, blue:0.59, alpha:1.0).cgColor
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
