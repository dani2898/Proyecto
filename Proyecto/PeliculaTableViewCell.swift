//
//  PeliculaTableViewCell.swift
//  Proyecto
//
//  Created by Jessica Villa on 28/01/21.
//

import UIKit

class PeliculaTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var peliculaLabel: UILabel!
    
    @IBOutlet weak var opinionTextView: UITextView!
    @IBOutlet weak var poster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
