//
//  NewProfileViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 24.07.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class NewProfileViewController: UIViewController {

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
        
        
            
        }
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil )
    }
    
    
}
