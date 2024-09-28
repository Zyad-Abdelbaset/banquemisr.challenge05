//
//  MovieCell.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    @IBOutlet weak var imgView: UIImageView!
    var model:Movie!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func putData() {
        lblTitle.text=model.title
        lblDate.text=model.releaseDate
    }
    
}
