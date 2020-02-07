//
//  UyeOlViewController.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 5.12.2019.
//  Copyright © 2019 Burak Yılmaz. All rights reserved.
//

import UIKit

class UyeOlController: UIViewController ,UITextFieldDelegate{
    
    var iconClick = true
    var uyeOlView = UyeOlView()
    @IBOutlet weak var uyeOlLabel: UILabel!
    @IBOutlet weak var adSoyadTF: UITextField!
    @IBOutlet weak var emailAdresiTF: UITextField!
    @IBOutlet weak var parolaTF: UITextField!
    @IBOutlet weak var parolaTekrariTF: UITextField!
    @IBOutlet weak var uyeOlButton: UIButton!
    @IBOutlet weak var hesabınYokMuLabel: UILabel!
    @IBOutlet weak var girisYapButton: UIButton!
    @IBAction func girisYapButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func uyeOlButton(_ sender: Any) {
        self.showSpinner(onView: view)
        if(parolaTF.text == parolaTekrariTF.text){
            self.uyeOlView.createUser(adSoyad:adSoyadTF.text!, mailAdresi:emailAdresiTF.text! , parola : parolaTF.text!, completionHandler: {
                Dictionary in print(Dictionary)
                if(Dictionary == false){
                    DispatchQueue.main.async {
                        self.removeSpinner()
                        let alert = UIAlertController(title: "Warning", message: self.uyeOlView.errMsg, preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.removeSpinner()
                        let transition: CATransition = CATransition()
                        transition.duration = 0.5
                        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                        transition.type = CATransitionType.reveal
                        transition.subtype = CATransitionSubtype.fromBottom
                        self.view.window!.layer.add(transition, forKey: nil)
                        self.dismiss(animated: false, completion: nil)
                        
                        
                    }
                }
            })
        }
        else{
            self.removeSpinner()
            DispatchQueue.main.async {
                self.removeSpinner()
                let alert = UIAlertController(title: "Warning", message: "Passwords entered do not match.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
    }
    @IBAction func adSoyadTF(_ sender: Any) {
        adSoyadTF.textColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        adSoyadTF.backgroundColor = UIColor(red:0.22, green:0.24, blue:0.29, alpha:1.0)
        adSoyadTF.font =  UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    }
    @IBAction func emailAdresiTF(_ sender: Any) {
        emailAdresiTF.textColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        emailAdresiTF.backgroundColor = UIColor(red:0.22, green:0.24, blue:0.29, alpha:1.0)
        emailAdresiTF.font =  UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    }
    @IBAction func parolaTF(_ sender: Any) {
        parolaTF.textColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        parolaTF.backgroundColor = UIColor(red:0.22, green:0.24, blue:0.29, alpha:1.0)
        parolaTF.font =  UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    }
    
    @IBAction func parolaTekrariTF(_ sender: Any) {
        parolaTekrariTF.textColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        parolaTekrariTF.backgroundColor = UIColor(red:0.22, green:0.24, blue:0.29, alpha:1.0)
        parolaTekrariTF.font =  UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        
        uyeOlButton.backgroundColor = UIColor(red:0.01, green:0.44, blue:0.98, alpha:1.0)
        uyeOlButton.setTitleColor(UIColor.white, for: .normal)
        uyeOlButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        uyeOlButton.layer.borderWidth = 0
    }
    @IBAction func showPassword(_ sender: Any) {
        if(iconClick == true) {
            parolaTF.isSecureTextEntry = false
        } else {
            parolaTF.isSecureTextEntry =  true
        }
        iconClick = !iconClick
    }
    @IBAction func showPassword2(_ sender: Any) {
        if(iconClick == true) {
            parolaTekrariTF.isSecureTextEntry = false
        } else {
            parolaTekrariTF.isSecureTextEntry =  true
        }
        iconClick = !iconClick
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        padding()
    }
    
    func padding(){
        view.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
        
        adSoyadTF.delegate = self
        emailAdresiTF.delegate = self
        parolaTF.delegate = self
        parolaTekrariTF.delegate = self
        
        adSoyadTF.layer.cornerRadius = 15
        emailAdresiTF.layer.cornerRadius = 15
        parolaTF.layer.cornerRadius = 15
        parolaTekrariTF.layer.cornerRadius = 15
        uyeOlButton.layer.cornerRadius = 15
        
        adSoyadTF.attributedPlaceholder = NSAttributedString(string: "Name, Surname", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red:0.50, green:0.54, blue:0.59, alpha:1.0)])
        emailAdresiTF.attributedPlaceholder = NSAttributedString(string: "E-mail address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red:0.50, green:0.54, blue:0.59, alpha:1.0)])
        parolaTF.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red:0.50, green:0.54, blue:0.59, alpha:1.0)])
        parolaTekrariTF.attributedPlaceholder = NSAttributedString(string: "Password (Again)", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red:0.50, green:0.54, blue:0.59, alpha:1.0)])
        
        uyeOlButton.layer.borderWidth = 1.0
        uyeOlButton.layer.borderColor = UIColor(red:0.59, green:0.59, blue:0.59, alpha:1.0).cgColor
        
        adSoyadTF.backgroundColor = UIColor(red:0.15, green:0.16, blue:0.20, alpha:1.0)
        emailAdresiTF.backgroundColor = UIColor(red:0.15, green:0.16, blue:0.20, alpha:1.0)
        parolaTF.backgroundColor = UIColor(red:0.15, green:0.16, blue:0.20, alpha:1.0)
        parolaTekrariTF.backgroundColor = UIColor(red:0.15, green:0.16, blue:0.20, alpha:1.0)
        
        adSoyadTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        emailAdresiTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        parolaTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        parolaTekrariTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        
        uyeOlButton.setTitleColor(UIColor(red:0.65, green:0.69, blue:0.73, alpha:1.0), for:.normal)
        uyeOlLabel.textColor = UIColor(red:0.91, green:0.92, blue:0.92, alpha:1.0)
        
        hesabınYokMuLabel.textColor = UIColor(red:0.65, green:0.69, blue:0.73, alpha:1.0)
        girisYapButton.setTitleColor(UIColor.white, for: .normal)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
