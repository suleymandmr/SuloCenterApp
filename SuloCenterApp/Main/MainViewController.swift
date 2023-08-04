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
    var menu: SideMenuNavigationController?
    var imageArray = [String]()
    var subjectArray = [String]()
    

    
    let fireStoreDatabase = Firestore.firestore()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = true
        tableView.dataSource = self
        tableView.delegate = self
    
        getDataFromFirebase()
    
        
        menu = SideMenuNavigationController(rootViewController: MenuListeController())
        menu?.leftSide = true
        //menu?.setNavigationBarHidden(true, animated: true)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        //SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        
    }
    
    
    @IBAction func didTopMenu(){
      present(menu!,animated: true)
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
            self.navigationController?.pushViewController(next, animated: true)
        }
        
        if(indexPath.row == 2){
            let next = self.storyboard?.instantiateViewController(withIdentifier: "SinemaViewController") as! SinemaViewController
           
               //next.photoData = photoData
               //self.present(next, animated: true, completion: nil)
            self.navigationController?.pushViewController(next, animated: true)
        }
        if(indexPath.row == 3){
            let next = self.storyboard?.instantiateViewController(withIdentifier: "EtkinlikViewController") as! EtkinlikViewController
           
               //next.photoData = photoData
               //self.present(next, animated: true, completion: nil)
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
}

class MenuListeController: UITableViewController{
    
    var items = ["Mağazalar", "Etkinlikler", "Sinema","Navigasyon", "Hakkımızda","Hesabım"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .darkGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor  = .darkGray
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)

        
        switch indexPath.row{
        case 0:
           // let sinemaViewController = TestViewController()
            //navigationController!.pushViewController(sinemaViewController, animated: true)
            
            /*let navigationViewController = storyBoard.instantiateViewController(withIdentifier: "SinemaViewController") as! SinemaViewController
        
            navigationController?.pushViewController(navigationViewController, animated: true)*/
            
            
            let navigationViewController = storyBoard.instantiateViewController(withIdentifier: "MagazalarViewController") as! MagazalarViewController
        
            navigationController?.pushViewController(navigationViewController, animated: true)
            break
        case 1:
            /*let navigationViewController = storyBoard.instantiateViewController(withIdentifier: "HakkindaViewController") as! HakkindaViewController
            navigationViewController.modalPresentationStyle = .fullScreen
            
            present(navigationViewController, animated: false )*/
            let navigationViewController = storyBoard.instantiateViewController(withIdentifier: "EtkinlikViewController") as! EtkinlikViewController
        
            navigationController?.pushViewController(navigationViewController, animated: true)
            break
        case 2:
            let navigationViewController = storyBoard.instantiateViewController(withIdentifier: "SinemaViewController") as! SinemaViewController
        
            navigationController?.pushViewController(navigationViewController, animated: true)
            
        
            break
        case 3:
            let navigationViewController = storyBoard.instantiateViewController(withIdentifier: "NavigationViewController") as! NavigationViewController
        
            navigationController?.pushViewController(navigationViewController, animated: true)
            
        
            break
        case 4:
            let navigationViewController = storyBoard.instantiateViewController(withIdentifier: "HakkindaViewController") as! HakkindaViewController
        
            navigationController?.pushViewController(navigationViewController, animated: true)
            
        
            break
        case 5:
            let navigationViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        
            navigationController?.pushViewController(navigationViewController, animated: true)
            
        
            break
        default:
            break
        }
    }
}



  
