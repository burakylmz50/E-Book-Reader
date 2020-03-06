//
//  MyLibraryController.swift
//  KitaplikApp
//
//  Created by Burak Yılmaz on 28.01.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import UIKit
import CoreData
import FolioReaderKit


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
        let tabBar = tabBarController as! TabBarController
        print(dizi[indexPath.row].bookLink)
        print(dizi[indexPath.row].isim)
        doubleTapped(abc: dizi[indexPath.row].bookLink!, abc2: indexPath.row)
        print(indexPath.row)
    }
    
    @IBOutlet weak var myLibraryTableView: UITableView!
    var soba : String = ""
    var soba2 : [String] = []
    
    var kitaplarLinkleri : [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        let tabBar = tabBarController as! TabBarController
        // labelDeneme.text = tabBar.myVariable
        
        if(tabBar.myVariable == ""){
            //             verileriGetir()
            if(dizi.count == 0){
                let alert = UIAlertController(title: "We are so sorry.", message: "You have not added any books to your library so far.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in myFunc()}))
                self.present(alert, animated: true, completion: nil)
            }
            func myFunc(){
                self.performSegue(withIdentifier: "myLibraryToTabBar", sender: nil)
            }
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
                    yeniKategeri.bookLink = tabBar.kitapLink
                    
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
        self.myLibraryTableView.separatorStyle = .none
        myLibraryTableView.reloadData()
    }
    func showSavedEpub( fileName:String) {
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains(fileName) {
                        // its your file! do what you want with it!
                        self.open(bookPath: url.path)
                        break
                    }
                }
            } catch {
                print("could not locate epub file !!!!!!!")
            }
        }
    }
    func open(bookPath:String) {
        let config = FolioReaderConfig()
        config.shouldHideNavigationOnTap = true
        config.scrollDirection = .horizontal
        let folioReader = FolioReader()
        folioReader.presentReader(parentViewController: self, withEpubPath: bookPath, andConfig: config)
        self.removeSpinner()
    }
    
    
    //    Download
    func doubleTapped(abc : String,abc2 : Int) {
        self.showSpinner(onView: self.view)
        
        let abcd = String(abc2)
        if let fileUrl = URL(string: abc) {
            
            //    self.indicatorView?.startAnimating()
            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(fileUrl.lastPathComponent+abcd+".epub")
            print(destinationUrl)
            
            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                //       self.indicatorView?.stopAnimating()
                print("The file already exists at path")
                // if the file doesn't exist
                DispatchQueue.main.async {
                    self.showSavedEpub(fileName:destinationUrl.lastPathComponent)
                }
            } else {
                
                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: fileUrl) { location, response, error in
                    guard let location = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationUrl)
                        print("DOWNLOAD COMPLETED: File moved to documents folder")
                        
                        DispatchQueue.main.async {
                            //              self.indicatorView?.stopAnimating()
                            self.showSavedEpub(fileName:destinationUrl.lastPathComponent)
                        }
                        
                    } catch {
                        print(error)
                    }
                }.resume()
            }
        }
    }
    
}
