//
//  ViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 24.07.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initializeHideKeyboard()
        // Do any additional setup after loading the view.
    }
    @IBAction func girisYapClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != ""{
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toMainVC", sender: nil)
                }
            }
        }else{
            makeAlert(titleInput: "Error", messageInput: "Userename/Password")
        }
        
    }
    @IBAction func sifreUnuttumClicked(_ sender: Any) {
        
        
        
        let alertController = UIAlertController(title: "E-Posta Adresi", message: "Lütfen e-posta adresinizi girin:", preferredStyle: .alert)

          // E-posta girme alanı ekle
          alertController.addTextField { (textField) in
              textField.placeholder = "E-posta adresi"
          }

          // Vazgeç aksiyonunu ekle
          let cancelAction = UIAlertAction(title: "Vazgeç", style: .cancel) { (_) in
              // Vazgeç butonuna tıklandığında yapılacak işlemler (opsiyonel)
          }
          alertController.addAction(cancelAction)

          // Tamam aksiyonunu ekle
          let okAction = UIAlertAction(title: "Tamam", style: .default) { (_) in
              if let email = alertController.textFields?.first?.text {
                  // Burada e-posta adresiyle yapılacak işlemleri gerçekleştirin.
                  print("Girilen e-posta adresi: \(email)")
              }
          }
          alertController.addAction(okAction)

          // UIAlertController'ı görüntüle
          self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func uyeOlClicked(_ sender: Any) {
    }
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil )
    }
    @IBAction func uyeOlmadanClicked(_ sender: Any) {
        performSegue(withIdentifier: "toMainVC", sender: nil)
    }
    
}


extension ViewController {

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
