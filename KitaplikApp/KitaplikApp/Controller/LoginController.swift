//
//  ViewController.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 24.11.2019.
//  Copyright © 2019 Burak Yılmaz. All rights reserved.
//

import UIKit
import FolioReaderKit

//    let openEpubFile = OpenEpubFile()
//    @IBAction func asdad(_ sender: Any) {
//        openEpubFile.doubleTapped(abc: 1,myController:self)
//    }

class LoginController: UIViewController , UITextFieldDelegate{
    
    var girdiMi : Bool = false
    var iconClick = true
    var loginView = LoginView()
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var girisYapLabel: UILabel!
    @IBOutlet weak var emailAdresiTF: UITextField!
    @IBOutlet weak var parolaTF: UITextField!
    @IBOutlet weak var girisYapButton: UIButton!
    @IBAction func girisYapButton(_ sender: Any) {
        //         self.performSegue(withIdentifier: "LoginToTabBar", sender: self)
        self.showSpinner(onView: view)
        self.loginView.userLogin(epostaAdresi:emailAdresiTF.text! , parola : parolaTF.text!, completionHandler: {
            Dictionary in print(Dictionary)
            if(Dictionary == false){
                DispatchQueue.main.async {
                    self.removeSpinner()
                    let alert = UIAlertController(title: "Warning", message: self.loginView.errorMessage, preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else{
                DispatchQueue.main.async {
                    self.removeSpinner()
                    self.defaults.set(true, forKey: "girdiMi")
                    self.performSegue(withIdentifier: "LoginToTabBar", sender: self)
                }
            }
        })
    }
    @IBAction func sifremiUnuttumButton(_ sender: Any) {
    }
    @IBOutlet weak var veyaLabel: UILabel!
    @IBOutlet weak var sifremiUnuttumButton: UIButton!
    @IBOutlet weak var hesabınYokMuLabel: UILabel!
    @IBOutlet weak var uyeOlButton: UIButton!
    
    @IBAction func emailAdresiTF(_ sender: Any) {
        emailAdresiTF.textColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        emailAdresiTF.backgroundColor = UIColor(red:0.22, green:0.24, blue:0.29, alpha:1.0)
        emailAdresiTF.font =  UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        girisYapButton.backgroundColor = UIColor(red:0.01, green:0.44, blue:0.98, alpha:1.0)
        girisYapButton.setTitleColor(UIColor.white, for: .normal)
        girisYapButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        girisYapButton.layer.borderWidth = 0
    }
    //Editing Changed
    @IBAction func parolaTF(_ sender: Any) {
        parolaTF.textColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        parolaTF.backgroundColor = UIColor(red:0.22, green:0.24, blue:0.29, alpha:1.0)
        parolaTF.font =  UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    }
    @IBAction func showPassword(_ sender: Any) {
        if(iconClick == true) {
            parolaTF.isSecureTextEntry = false
        } else {
            parolaTF.isSecureTextEntry =  true
        }
        iconClick = !iconClick
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        padding()
    }
    
    
    func padding(){
        view.backgroundColor = UIColor(red:0.07, green:0.09, blue:0.13, alpha:1.0)
        
        girisYapButton.setTitleColor(UIColor(red:0.65, green:0.69, blue:0.73, alpha:1.0), for:.normal)
        sifremiUnuttumButton.setTitleColor(UIColor(red:0.65, green:0.69, blue:0.73, alpha:1.0), for:.normal)
        veyaLabel.textColor = UIColor(red:0.65, green:0.69, blue:0.73, alpha:1.0)
        girisYapLabel.textColor = UIColor(red:0.91, green:0.92, blue:0.92, alpha:1.0)
        hesabınYokMuLabel.textColor = UIColor(red:0.65, green:0.69, blue:0.73, alpha:1.0)
        uyeOlButton.setTitleColor(UIColor.white, for: .normal)
        
        
        emailAdresiTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        parolaTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        
        emailAdresiTF.delegate = self
        parolaTF.delegate = self
        
        emailAdresiTF.layer.cornerRadius = 15
        parolaTF.layer.cornerRadius = 15
        girisYapButton.layer.cornerRadius = 15
        
        emailAdresiTF.backgroundColor = UIColor(red:0.15, green:0.16, blue:0.20, alpha:1.0)
        parolaTF.backgroundColor = UIColor(red:0.15, green:0.16, blue:0.20, alpha:1.0)
        
        girisYapButton.layer.borderWidth = 1.0
        girisYapButton.layer.borderColor = UIColor(red:0.59, green:0.59, blue:0.59, alpha:1.0).cgColor
        
        
        emailAdresiTF.attributedPlaceholder = NSAttributedString(string: "E-mail address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red:0.50, green:0.54, blue:0.59, alpha:1.0)])
        parolaTF.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red:0.50, green:0.54, blue:0.59, alpha:1.0)])
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

