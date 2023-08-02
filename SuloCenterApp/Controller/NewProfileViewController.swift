//
//  NewProfileViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 24.07.2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase


class NewProfileViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var isimLabel: UITextField!
    @IBOutlet weak var soyisimLabel: UITextField!
    @IBOutlet weak var epostaLabel: UITextField!
    
    @IBOutlet weak var sifreLabel: UITextField!
    @IBOutlet weak var sehirLabel: UITextField!
    @IBOutlet weak var cinsiyetLabel: UITextField!
    @IBOutlet weak var telefonLabel: UITextField!
    @IBOutlet weak var dogumLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        // Do any additional setup after loading the view.
    }
    

  
    @IBAction func kayitClicket(_ sender: Any) {
        if epostaLabel.text != "" && sifreLabel.text != "" {
            Auth.auth().createUser(withEmail: epostaLabel.text!, password: sifreLabel.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toCreateUser", sender: nil)
                }
            }
        }else{
          makeAlert(titleInput: "Error", messageInput: "Userename/Password")
        }
        
        let firestoreDatabase = Firestore.firestore()

        // Realtime Database referansı
        let realtimeDatabaseRef = Database.database().reference()

        // Firestore veri yapısını hazırlayın
        let firestorePost = [
            "Isim": self.isimLabel.text!,
            "Soyisim": self.soyisimLabel.text!,
            "Eposta": self.epostaLabel.text!,
            "Sehir": self.sehirLabel.text!,
            "Cinsiyet": self.cinsiyetLabel.text!,
            "Telefon": self.telefonLabel.text!,
            "Dogum": self.dogumLabel.text!,
            "date": ServerValue.timestamp()
        ] as [String: Any]

        // Realtime Database verisini ekleyin
        realtimeDatabaseRef.child("Posts").childByAutoId().setValue(firestorePost) { (error, ref) in
            if let error = error {
                self.makeAlert(titleInput: "Error!", messageInput: error.localizedDescription)
            } else {
                // Başarıyla eklendiğinde yapılacak işlemler
            }
        }
            
        }
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil )
    }
    
    @IBAction func GeriClicked(_ sender: Any) {
        
    }
    
}
extension NewProfileViewController {

    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))

        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }

    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
}
