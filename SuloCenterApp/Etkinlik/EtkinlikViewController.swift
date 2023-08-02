//
//  EtkinlikViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 31.07.2023.
//

import UIKit
import Firebase
import SDWebImage

class EtkinlikViewController: UIViewController {
    
    var imageArray = [String]()
    var subjectArray = [String]()
    var AciklamaArray = [String]()
    
    let fireStoreDatabase = Firestore.firestore()
    
    var etkinlikler: [String] = ["URL_OF_IMAGE_1", "URL_OF_IMAGE_2", "URL_OF_IMAGE_3"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = true
        tableView.dataSource = self
        tableView.delegate = self
        
        getDataFromFirebase()
        
        
    }
    

    func getDataFromFirebase (){
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Etkinlik").order(by: "id", descending: false)
            .addSnapshotListener { snapshot, error in
            
            if error != nil {
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.imageArray.removeAll(keepingCapacity: false)
                    self.subjectArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        let documentID = document.documentID
                        
                        if let imageArry = document.get("Image") as? String {
                            self.imageArray.append(imageArry)
                            
                        }
                        if let subjectArry = document.get("Subject") as? String {
                            self.subjectArray.append(subjectArry)
                            
                        }
                        if let aciklamaArry = document.get("Aciklama") as? String{
                            self.AciklamaArray.append(aciklamaArry)
                        }
                        
                    }
                    self.tableView.reloadData()
                }
                    
            }
        }
    }
    
}
extension EtkinlikViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectArray.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EtkinlikCell
               cell.etkinlikLabel.text = subjectArray[indexPath.row]
               cell.etkinlikImageView.sd_setImage(with: URL(string: imageArray[indexPath.row]), completed: nil)
               return cell
    }

   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
  
  
      
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let imageUrlString = imageArray[indexPath.row]
            if let imageUrl = URL(string: imageUrlString) {
                SDWebImageDownloader.shared.downloadImage(with: imageUrl, options: [], progress: nil) { (image, _, error, _) in
                    if let error = error {
                        print("Error downloading image: \(error)")
                    } else if let image = image {
                        DispatchQueue.main.async {
                            let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetayVC") as! DetayVC
                            detailViewController.image = image // Gelen resmi DetailViewController'a gönder
                            detailViewController.detailText = self.AciklamaArray[indexPath.row]
                            self.navigationController?.pushViewController(detailViewController, animated: true)
                        }
                    }
                }
            }
        }

       }

