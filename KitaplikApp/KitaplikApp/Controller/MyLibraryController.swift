//
//  MyLibraryController.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 28.01.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import UIKit
import CoreData


class MyLibraryController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dizi  = [Kategori]()
    
    func verileriKaydet(){
        do{
            print("ayse")
            try self.context.save()
            print("ayse111")
        }
        catch{
            print(error.localizedDescription)
        }
    }
    func verileriGetir(){
        let talep : NSFetchRequest<Kategori> = Kategori.fetchRequest()
        do{
            print("ayse2")
            dizi = try  context.fetch(talep)
//                        myLibraryTableView.reloadData()
        }
        catch{
            print(error.localizedDescription)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dizi.count )
        return dizi.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myLibraryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyLibraryTableViewCell
        
        print("ali")
        guard let url = URL(string: dizi[indexPath.row].isim!) else { return cell }
        URLSession.shared.dataTask(with: url){
            (data,response,error) in
            if error != nil{
                print("error")
                return
            }
            DispatchQueue.main.async {
                cell.bookImage.image = UIImage(data : data!)
                //                self.myLibraryTableView.reloadData()
            }
        }.resume()
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    
    @IBOutlet weak var myLibraryTableView: UITableView!
    @IBOutlet weak var labelDeneme: UILabel!
    var soba : String = ""
    var soba2 : [String] = []
    
    var kitaplarLinkleri : [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
       
        let tabBar = tabBarController as! TabBarController
        // labelDeneme.text = tabBar.myVariable
       
        if(tabBar.myVariable == ""){
//             verileriGetir()
        }
        else{
             let yeniKategeri = Kategori(context: self.context)
            if dizi.contains(where: {$0.isim == tabBar.myVariable}) {
                myLibraryTableView.reloadData()
               print("var bundan")
            } else {
               //item could not be found
                           soba2.append(tabBar.myVariable)
                           if(tabBar.myVariable != soba2.last){
                               
                           }
                           else{

                                           yeniKategeri.isim = tabBar.myVariable

                                           
                                                  dizi.append(yeniKategeri)
                
                               //            print("adad" + dizi.last!.isim! + "adasd")
                               //                print("adad" + dizi.first!.isim! + "adasd")
                                                  verileriKaydet()
                                                  
                                                  myLibraryTableView.reloadData()
                           }
            }
            print("mustafa")

            
        }
       
        
        
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verileriGetir()
        myLibraryTableView.reloadData()
    }
    
}
