//
//  MovieCell.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var lblVoteCount: UILabel!
    @IBOutlet weak var lblAvgVote: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    var viewModel:MovieCellViewModel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func putData() {
        imgView.layer.cornerRadius=20
        lblTitle.text=viewModel.model.title
        lblDate.text=viewModel.model.releaseDate
        viewModel.getMovieImage(completion: { result in
            switch result{
            case .success(let data): DispatchQueue.main.async {
                self.imgView.image = UIImage(data: data)
            }
            case .failure(_):DispatchQueue.main.async {
                self.imgView.image = UIImage(named: "defaultImage")
            }
                
            }
        })
        
    }
}
