//
//  MainCell.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 25.07.2023.
//

import UIKit


class MainCell: UITableViewCell {
    
    @IBOutlet weak var detayImageView: UIImageView!
    
   
    @IBOutlet weak var detayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
