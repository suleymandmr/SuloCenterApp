//
//  hakkimizda2ViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 26.07.2023.
//

import UIKit

class hakkimizda2ViewController: UIViewController {

    @IBOutlet weak var textField: UILabel!
    @IBOutlet weak var myButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIPasteboard.general.string = "+905437757575"
        let content = UIPasteboard.general.string

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   
}
