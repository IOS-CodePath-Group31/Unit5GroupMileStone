//
//  MembersTableViewCell.swift
//  Friendie
//
//  Created by Jibril Mohamed on 4/22/22.
//

import UIKit

class MembersTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var memberUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
