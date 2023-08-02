//
//  EtkinlikDetayViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 1.08.2023.
//

import UIKit

class DetayVC: UIViewController {
    var image: UIImage?
       var detailText: String = ""
    
    @IBOutlet weak var detayImage: UIImageView!
   
    @IBOutlet weak var detailLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ImageView'a Firebase'den alınan resmi atayın
        detayImage.image = image

        // Detay Label'ına metni atayın
        detailLabel.text = detailText
        
    }
    func alignImageToRight(_ imageView: UIImageView) {
        guard let imagee = detayImage.image else { return }
        
        let screenWidth = UIScreen.main.bounds.width
        
        let imageAspect = imagee.size.width / imagee.size.height
        let newWidth = screenWidth
        let newHeight = screenWidth / imageAspect
        
        detayImage.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
    }
    func alignImageToLeft(_ imageView: UIImageView) {
        guard let imagee = detayImage.image else { return }
        
        let screenWidth = UIScreen.main.bounds.width
        
        let imageAspect = imagee.size.width / imagee.size.height
        let newWidth = screenWidth
        let newHeight = screenWidth / imageAspect
        
        detayImage.frame = CGRect(x: screenWidth - newWidth, y: 0, width: newWidth, height: newHeight)
    }
    
}
