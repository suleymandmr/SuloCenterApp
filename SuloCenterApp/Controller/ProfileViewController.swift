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
    var currentUserID: String?
    var about = ["Cinsiyet","Dogum","Eposta","Isim","Sehir","Soyisim","Telefon" ]
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // Kullanıcı oturum açmışsa, kullanıcının kimliğini alıyoruz
                self.currentUserID = user.uid
                
                // Kullanıcının profil verilerini çekiyoruz ve ekranda gösteriyoruz
                self.fetchUserProfile()
            } else {
                // Kullanıcı oturum açmamışsa, uygun bir şekilde yönlendirme yapabiliriz.
                print("Kullanıcı oturum açmamış.")
            }
        }
    
    }
    
  
    func fetchUserProfile() {
           // Kullanıcının kimliğini kontrol ediyoruz
           guard let userID = self.currentUserID else {
               return
           }
           
           // Veritabanı referansını alıyoruz
           let ref = Database.database().reference()
           
           // Kullanıcının verilerini çekiyoruz
           ref.child("Posts").child(userID).observeSingleEvent(of: .value) { (snapshot, error) in
               if let userData = snapshot.value as? [String: Any] {
                   // Kullanıcının verilerini ekranda gösteriyoruz
                   self.isimLabel.text = userData["Isim"] as? String
                   self.epostaLabel.text = userData["Eposta"] as? String
                   self.sehirLabel.text = userData["Sehir"] as? String
                   self.cinsiyetLabel.text = userData["Cinsiyet"] as? String
                   self.phoneLabel.text = userData["Telefon"] as? String
                   self.dogumLabel.text = userData["Dogum"] as? String
                   self.soyisimLabel.text = userData["Soyisim"] as? String
               } else {
                   print("Kullanıcı verileri bulunamadı.")
               }
           } withCancel: { (error) in
               print("Veri çekme hatası: \(error.localizedDescription)")
           }
       }
    
    

    @IBAction func silClicked(_ sender: Any) {
    }
    @IBAction func guncelleClicked(_ sender: Any) {
        // Güncellenmiş kullanıcı adı ve e-postayı alıyoruz
               guard let newUsername = isimLabel.text,
                     let newEmail = epostaLabel.text,
                     let newSehir = sehirLabel.text,
                     let newCinsiyet = cinsiyetLabel.text,
                     let newPhone = phoneLabel.text,
                     let newDogum = dogumLabel.text,
                     let newSoyisim = soyisimLabel.text,
                     let userID = self.currentUserID else {
                   return
               }
               
               // Veritabanı referansını alıyoruz
               let ref = Database.database().reference()
               
               // Kullanıcının verilerini güncelliyoruz
               let userRef = ref.child("Posts").child(userID)
        userRef.updateChildValues(["Isim": newUsername, "Eposta": newEmail, "Sehir": newSehir,"Cinsiyet": newCinsiyet,"Telefon": newPhone, "Dogum": newDogum, "Soyisim": newSoyisim]) { (error, ref) in
                   if let error = error {
                       print("Veri güncelleme hatası: \(error.localizedDescription)")
                   } else {
                       print("Veri başarıyla güncellendi.")
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
extension ProfileViewController {

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
