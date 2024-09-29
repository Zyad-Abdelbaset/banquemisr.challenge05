//
//  MoviesViewController.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var imgViewNoData: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var viewModel:MoviesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSelectedTabBarData()
        setupBeforeLoading()
        setUpTabBarItems()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.setupActivityIndicator(in: self.view)
        activityIndicator.showActivityIndicator()
        self.tableView.isHidden = true
        self.imgViewNoData.isHidden = true
        setUpNavigationTitle()
        viewModel.fetchMovies()
        viewModel.navigateForward = {str in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController")as! MovieDetailsViewController
            vc.viewModel = MovieDetailsViewModel(movieId:str)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func setupBeforeLoading(){
        tableView.delegate=self
        tableView.dataSource=self
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieCell")
        viewModel.reloadTV = {
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.setUpNavigationTitle()
            self.activityIndicator.hideActivityIndicator()
        }
        viewModel.noResult={str in
            self.presentAlert(title: "Error", message: str, buttonTitle: "OK")
            if(self.viewModel.arrMovies.count == 0){
                self.tableView.isHidden = true
                self.imgViewNoData.isHidden = false
            }
            
        }
    }
    
}

//MARK: - TableView SetUp Protocol
extension MoviesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.arrMovies.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.viewModel = MovieCellViewModel(model: viewModel.arrMovies[indexPath.row])
        cell.putData()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateForward("\(viewModel.arrMovies[indexPath.row].id)")
    }
}
//MARK: - SetUp the tabarController
extension MoviesViewController{
    func setUpSelectedTabBarData(){
        switch self.tabBarController?.tabBar.selectedItem?.tag{
        case 0 :viewModel=MoviesViewModel(endPoint: .nowPlaying);
        case 1 :viewModel=MoviesViewModel(endPoint: .upcoming);
        case 2 :viewModel=MoviesViewModel(endPoint: .popular);
        default : viewModel = MoviesViewModel(endPoint: .nowPlaying);
        }
    }
    func setUpNavigationTitle(){
        switch self.tabBarController?.tabBar.selectedItem?.tag{
        case 0 :self.tabBarController?.title = "Now Playing \(viewModel.onlineFlag)"
        case 1 :self.tabBarController?.title = "UpComing \(viewModel.onlineFlag)"
        case 2 :self.tabBarController?.title = "Popular \(viewModel.onlineFlag)"
        default : viewModel = MoviesViewModel(endPoint: .nowPlaying);
        }
    }
    func setUpTabBarItems(){
        if let tabBar = self.tabBarController?.tabBar.items {
            tabBar[0].title = "now playing"
            tabBar[0].image = UIImage(systemName: "play.rectangle")
            tabBar[0].tag = 0
            
            tabBar[1].title = "upcoming"
            tabBar[1].image = UIImage(systemName: "clock.badge.questionmark")
            tabBar[1].tag = 1
            
            tabBar[2].title = "popular"
            tabBar[2].image = UIImage(systemName: "star.square")
            tabBar[2].tag = 2
        }
    }
}
