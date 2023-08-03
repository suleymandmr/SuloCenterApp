//
//  MagazalarViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 31.07.2023.
//

import UIKit
import Firebase
import SDWebImage

class MagazalarViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{
    let kattar = ["Zemin Kat", "1. Kat", "2. Kat", "3. Kat", "4. Kat", "5. Kat", "6. Kat", "7. Kat", "8. Kat"]
    var pickerView: UIPickerView!
    var imageArray = [String]()
    var nameArray = [String]()
    var numberArray = [String]()
    var selectedKat: String?
    
    
    let fireStoreDatabase = Firestore.firestore()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    
        getDataFromFirebase()
        
        
        pickerView = UIPickerView()
                pickerView.delegate = self
                pickerView.dataSource = self
                view.addSubview(pickerView)
                pickerView.isHidden = true // Başlangıçta gizli olacak

        // UIPickerView nesnesini oluşturun ve ekranınıza eklemeyin (ilk başta gizli olacak)
        pickerView = UIPickerView()
                pickerView.delegate = self
                pickerView.dataSource = self
                view.addSubview(pickerView)
                pickerView.isHidden = true // Başlangıçta gizli olacak

                // Katları seçmek için kullanılacak UIBarButtonItem'i oluşturun
                let katBarButtonItem = UIBarButtonItem(title: "Kat Seç", style: .plain, target: self, action: #selector(showPickerView))
                navigationItem.rightBarButtonItem = katBarButtonItem
       
    }
    @objc func showPickerView() {
         // UIPickerView'ı ekranın altına yerleştirin
         let pickerHeight: CGFloat = 300 // İstediğiniz yüksekliği burada belirleyebilirsiniz
         pickerView.frame = CGRect(x: 0, y: view.bounds.height - pickerHeight, width: view.bounds.width, height: pickerHeight)
         pickerView.isHidden = false
     }

     // UIPickerViewDelegate fonksiyonları
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return kattar[row]
     }

     // UIPickerViewDataSource fonksiyonları
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1 // Tek bir sütun kullanıyoruz
     }

     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return kattar.count
     }

     // Kullanıcı bir kattı seçtiğinde yapılacak işlemler
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         selectedKat = kattar[row]
         // Seçilen katı kullanarak ilgili işlemleri yapabilirsiniz (örneğin, seçilen kattaki mağazaları listeleyebilirsiniz)
         print("Seçilen kat: \(selectedKat ?? "")")
         pickerView.isHidden = true // Kullanıcı bir kattı seçtikten sonra UIPickerView'ı gizleyin
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
    
    @IBAction func buttonClicked(_ sender: Any) {
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
