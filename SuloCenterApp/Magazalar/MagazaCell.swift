//
//  MagazaCell.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 2.08.2023.
//

import UIKit

class MagazaCell: UITableViewCell {

    @IBOutlet weak var katLabel: UILabel!
    @IBOutlet weak var magazaLabel: UILabel!
    @IBOutlet weak var magazaImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
