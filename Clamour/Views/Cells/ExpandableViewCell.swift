//
//  ExpandableViewCell.swift
//  Clamour
//
//  Created by San Byn Nguyen on 20.04.2018.
//

import UIKit
import ExpandableCell

class ExpandableViewCell: ExpandableCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
