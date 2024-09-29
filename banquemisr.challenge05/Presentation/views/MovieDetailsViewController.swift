//
//  MovieDetailsViewController.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 28/09/2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var imgViewNoData: UIImageView!
    @IBOutlet weak var lblOverView: UILabel!
    @IBOutlet weak var lblRunTime: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblOriginalLanguage: UILabel!
    @IBOutlet weak var lblBudget: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblGeners: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgViewPoster: UIImageView!
    var activityIndicator = UIActivityIndicatorView()
    var viewModel:MovieDetailsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgViewPoster.layer.cornerRadius = 25
        viewModel.noResult={str in
            self.presentAlert(title: "Error", message: str, buttonTitle: "OK")
            self.imgViewNoData.isHidden = false
            
        }
        indicator.startAnimating()
        viewModel.putData={
            print(self.viewModel.movieId)
            self.lblTitle.text = self.viewModel.model!.title+"\(self.viewModel.model!.adult ? "(+18)" : "")"
            self.lblGeners.text = "Geners: "+self.viewModel.model!.genres.map({ item in
                item.name
            }).joined(separator: " - ")
            self.lblBudget.text = "Budget: \(self.viewModel.model!.budget)"
            self.lblStatus.text = "Status: "+self.viewModel.model!.status
            let hours = (self.viewModel.model!.runtime) / 60
            let minutes = (self.viewModel.model!.runtime) % 60
            self.lblRunTime.text = "Run time: \(hours)h \(minutes)m"
            self.lblOverView.text = self.viewModel.model!.overview
            self.lblReleaseDate.text = "Release Date: "+self.viewModel.model!.releaseDate
            self.lblOriginalLanguage.text = "Original language: "+self.viewModel.model!.originalLanguage
            
            self.viewModel.getMovieImage(completion: { result in
                switch result{
                case .success(let data): DispatchQueue.main.async {
                    self.imgViewPoster.image = UIImage(data: data)
                    self.indicator.stopAnimating()
                    self.indicator.hideActivityIndicator()
                }
                case .failure(_):DispatchQueue.main.async {
                    self.imgViewPoster.image = UIImage(named: "defaultImage")
                }
                    
                }
            })
            
        }
        // Do any additional setup after loading the view.
    }


}
