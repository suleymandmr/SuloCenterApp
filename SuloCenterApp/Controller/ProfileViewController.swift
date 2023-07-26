//
//  ProfileViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 24.07.2023.
//

import UIKit
import Firebase
import FirebaseDatabase
class ProfileViewController: UIViewController {

    @IBOutlet weak var epostaLabel: UITextField!
    @IBOutlet weak var ilceLabel: UITextField!
    @IBOutlet weak var sehirLabel: UITextField!
    @IBOutlet weak var cinsiyetLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var dogumLabel: UITextField!
    @IBOutlet weak var soyisimLabel: UITextField!
   
    @IBOutlet weak var isimLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func silClicked(_ sender: Any) {
    }
    @IBAction func guncelleClicked(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()

        // Realtime Database referansı
        let realtimeDatabaseRef = Database.database().reference()

        // Firestore veri yapısını hazırlayın
        let firestorePost = [
            "Isim": self.isimLabel.text!,
            "Ilce": self.ilceLabel.text!,
            "Soyisim": self.soyisimLabel.text!,
            "Eposta": self.epostaLabel.text!,
            "Sehir": self.sehirLabel.text!,
            "Cinsiyet": self.cinsiyetLabel.text!,
            "Telefon": self.phoneLabel.text!,
            "Dogum": self.dogumLabel.text!,
            "date": ServerValue.timestamp()
        ] as [String: Any]

        // Realtime Database verisini ekleyin
        realtimeDatabaseRef.child("Kullanıcılar").childByAutoId().setValue(firestorePost) { (error, ref) in
            if let error = error {
                self.makeAlert(titleInput: "Error!", messageInput: error.localizedDescription)
            } else {
                // Başarıyla eklendiğinde yapılacak işlemler
            }
        }
        
    }
    @IBAction func cıkısYapClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
                   
        } catch {
            print("error")
        }
    }
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil )
    }
    

    
}
