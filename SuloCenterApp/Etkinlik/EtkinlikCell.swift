//
//  EtkinlikCell.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 1.08.2023.
//

import UIKit

class EtkinlikCell: UITableViewCell {

 
    @IBOutlet weak var etkinlikImageView: UIImageView!
    @IBOutlet weak var etkinlikLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with imageUrl: String) {
         if let url = URL(string: imageUrl) {
             etkinlikImageView.sd_setImage(with: url, completed: nil)
         }
     }
}
