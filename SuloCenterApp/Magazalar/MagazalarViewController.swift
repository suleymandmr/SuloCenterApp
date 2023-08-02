//
//  MagazalarViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 31.07.2023.
//

import UIKit
import Firebase
import SDWebImage

class MagazalarViewController: UIViewController {

    var imageArray = [String]()
    var nameArray = [String]()
    var numberArray = [String]()
    
    let fireStoreDatabase = Firestore.firestore()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    
        getDataFromFirebase()
        
       
    }

    func getDataFromFirebase (){
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Magazalar").order(by: "id", descending: false)
            .addSnapshotListener { snapshot, error in
            
            if error != nil {
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.imageArray.removeAll(keepingCapacity: false)
                    self.nameArray.removeAll(keepingCapacity: false)
                    self.numberArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        let documentID = document.documentID
                        
                        if let imageArry = document.get("Image") as? String {
                            self.imageArray.append(imageArry)
                            
                        }
                        if let nameArry = document.get("Name") as? String {
                            self.nameArray.append(nameArry)
                            
                        }
                        if let numberArry = document.get("Number") as? String {
                            self.numberArray.append(numberArry)
                            
                        }
                        
                    }
                    self.tableView.reloadData()
                }
                    
            }
        }
    }
    
}
extension MagazalarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MagazaCell
        cell.magazaLabel.text = nameArray[indexPath.row]
        cell.katLabel.text = numberArray[indexPath.row]
        cell.magazaImageView.sd_setImage(with: URL(string: self.imageArray[indexPath.row]) )
        return cell
    }

   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
   
}

