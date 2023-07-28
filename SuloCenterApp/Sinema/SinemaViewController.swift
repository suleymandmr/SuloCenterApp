//
//  SinemaViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 27.07.2023.
//

import UIKit

class SinemaViewController: UIViewController {
    var photos: [String] = []
    var photoData: String?
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let photoURL = URL(string: photoData ?? "") {
            imageView.sd_setImage(with: photoURL, completed: nil)
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
}
