//
//  ProfileCell.swift
//  Clamour
//
//  Created by San Byn Nguyen on 20.04.2018.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profileInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
        // Configure the view for the selected state
    }

}
