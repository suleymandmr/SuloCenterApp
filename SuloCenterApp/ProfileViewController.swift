//
//  ProfileViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 24.07.2023.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController {

    @IBOutlet weak var epostaLabel: UITextField!
    @IBOutlet weak var ilceLabel: UITextField!
    @IBOutlet weak var sehirLabel: UITextField!
    @IBOutlet weak var cinsiyetLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var dogumLabel: UITextField!
    @IBOutlet weak var soyisimLabel: UITextField!
    @IBOutlet weak var isimLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func silClicked(_ sender: Any) {
    }
    @IBAction func guncelleClicked(_ sender: Any) {
    }
    @IBAction func cıkısYapClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
                   
        } catch {
            print("error")
        }
    }
    
}
