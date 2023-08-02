//
//  MainViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 24.07.2023.
//

import UIKit
import Firebase
import SDWebImage
import SideMenu


class MainViewController: UIViewController {
    
    var imageArray = [String]()
    var subjectArray = [String]()
    let menuItems = ["First", "Second"]

    
    let fireStoreDatabase = Firestore.firestore()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = true
        tableView.dataSource = self
        tableView.delegate = self
    
        getDataFromFirebase()
        
        let sideMenuViewController = SideMenuViewController()
        let menu = SideMenuNavigationController(rootViewController: sideMenuViewController)
              SideMenuManager.default.leftMenuNavigationController = menu
              
              // Yan menüyü açmak için bir buton ekleyin
              navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(didTopMenu))
        
      
        
        
        
        
        
        
    }
    
    
    @IBAction func didTopMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    func getDataFromFirebase (){
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Anasayfa").order(by: "id", descending: false)
            .addSnapshotListener { snapshot, error in
            
            if error != nil {
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.imageArray.removeAll(keepingCapacity: false)
                    self.subjectArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        let documentID = document.documentID
                        
                        if let imageArry = document.get("ImageArray") as? String {
                            self.imageArray.append(imageArry)
                            
                        }
                        if let subjectArry = document.get("Subject") as? String {
                            self.subjectArray.append(subjectArry)
                            
                        }
                        
                    }
                    self.tableView.reloadData()
                }
                    
            }
        }
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectArray.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainCell
        cell.detayLabel.text = subjectArray[indexPath.row]
        cell.detayImageView.sd_setImage(with: URL(string: self.imageArray[indexPath.row]) )
        return cell
    }

   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Fotoğrafa tıklama işlevini çağırın
        photoTapped(at: indexPath)
    }
}

extension MainViewController {
    func photoTapped(at indexPath: IndexPath) {
        
        print("Photo tapped at index: \(indexPath.row)")
        
        if(indexPath.row == 1){
            let next = self.storyboard?.instantiateViewController(withIdentifier: "MagazalarViewController") as! MagazalarViewController
           
               //next.photoData = photoData
               //self.present(next, animated: true, completion: nil)
            self.navigationController?.pushViewController(next, animated: false)
        }
        
        if(indexPath.row == 2){
            let next = self.storyboard?.instantiateViewController(withIdentifier: "SinemaViewController") as! SinemaViewController
           
               //next.photoData = photoData
               //self.present(next, animated: true, completion: nil)
            self.navigationController?.pushViewController(next, animated: false)
        }
        if(indexPath.row == 3){
            let next = self.storyboard?.instantiateViewController(withIdentifier: "EtkinlikViewController") as! EtkinlikViewController
           
               //next.photoData = photoData
               //self.present(next, animated: true, completion: nil)
            self.navigationController?.pushViewController(next, animated: false)
        }
    }
    
}

extension MainViewController: SideMenuDelegate {
    func didSelectMenuItem(title: String) {
        // Yan menüden seçilen öğelere göre ilgili sayfaya yönlendirme işlemini burada yapabilirsiniz.
        switch title {
        case "First":
            let firstViewController = NavigationViewController()
            navigationController?.pushViewController(firstViewController, animated: true)
        case "Second":
            let secondViewController = HakkindaViewController()
            navigationController?.pushViewController(secondViewController, animated: true)
        default:
            break
        }
        
        // Sayfaya geçiş yaptıktan sonra yan menüyü kapatın
        SideMenuManager.default.leftMenuNavigationController?.dismiss(animated: true, completion: nil)
    }
}
