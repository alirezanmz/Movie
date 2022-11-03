//
//  ViewController.swift
//  Movie
//
//  Created by Alireza Namazi on 4/21/22.
//

import UIKit
import Kingfisher
import SwiftUI
import GSMessages
class MoviesViewController: UIViewController{
    // MARK: Class props
    var MoviesList:[Movies] = []
    var FavoriteMovies:[Movies] = []
    var WatchedMovies:[Movies] = []
    var MustWatchedMovies:[Movies] = []
    var FavoriteIDs:[Favorite] = []
    var setSelectedDataForDetail:Movies?
    
    // MARK: connections
    private lazy var layout: UICollectionViewFlowLayout = {
       let collectionViewFlowLayout = UICollectionViewFlowLayout()
          collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
          collectionViewFlowLayout.minimumInteritemSpacing = 20
          collectionViewFlowLayout.minimumLineSpacing = 26
          collectionViewFlowLayout.scrollDirection = .horizontal
        return collectionViewFlowLayout
    }()
   
    var FavoriteListCollectionView: UICollectionView!
    
    private lazy var MustWatchedListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(MustWatchMoviesTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.tag = 2
        return tableView
    }()
    
    private lazy var WatchedListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(WatchedMoviesTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tag = 1
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var NextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 25)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.setTitle("Next", for: .normal)
        button.backgroundColor = Constants.BackgroundColor.LightGray
        button.addTarget(self, action: #selector(NextBtn), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0
        return stackView
    }()
    
    private lazy var FavoriteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var WatchedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var MustWatchedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var FavoriteTopicName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 10, y: 0, width: 200, height: 30)
        label.textColor = .lightGray
        label.font = UIFont(name: "Avenir-Book", size: 25)
        label.text = "Favorites"
        return label
    }()
    
    private lazy var WatchedTopicName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 10, y: 0, width: 200, height: 30)
        label.frame = CGRect(x: 10, y: 0, width: 200, height: 30)
        label.textColor = .lightGray
        label.font = UIFont(name: "Avenir-Book", size: 25)
        label.text = "Watched"
        return label
    }()
    
    private lazy var MustWatchedTopicName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 10, y: 0, width: 200, height: 30)
        label.frame = CGRect(x: 10, y: 0, width: 200, height: 30)
        label.textColor = .lightGray
        label.font = UIFont(name: "Avenir-Book", size: 25)
        label.text = "Must watch"
        return label
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
    }
}

// MARK: Extensions

// MARK: MoviesViewController extensions
extension MoviesViewController {
    // MARK: Class methods
    func configureUI() {

        FavoriteListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        FavoriteListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        FavoriteListCollectionView.register(FavoriteMoviesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        FavoriteListCollectionView.showsHorizontalScrollIndicator = false
        
        navigationItem.title = "Movies App"
        view.backgroundColor = .white
    
        view.addSubview(FavoriteView)
  
        FavoriteView.addSubview(FavoriteTopicName)
        FavoriteView.addSubview(FavoriteListCollectionView)
        view.addSubview(stackView)

        stackView.addArrangedSubview(WatchedView)
        WatchedView.addSubview(WatchedTopicName)
        stackView.addArrangedSubview(MustWatchedView)
        WatchedView.addSubview(WatchedListTableView)
        
        MustWatchedView.addSubview(MustWatchedTopicName)
        MustWatchedView.addSubview(MustWatchedListTableView)
        view.addSubview(NextButton)
        
        
        
        FavoriteView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        FavoriteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        FavoriteView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        FavoriteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
    
        
        
        FavoriteListCollectionView.topAnchor.constraint(equalTo: FavoriteView.topAnchor, constant: 30).isActive = true
        FavoriteListCollectionView.leadingAnchor.constraint(equalTo: FavoriteView.leadingAnchor, constant: 0).isActive = true
        FavoriteListCollectionView.trailingAnchor.constraint(equalTo: FavoriteView.trailingAnchor, constant: 0).isActive = true
        FavoriteListCollectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        WatchedListTableView.topAnchor.constraint(equalTo: WatchedView.topAnchor, constant: 30).isActive = true
        WatchedListTableView.leadingAnchor.constraint(equalTo: WatchedView.leadingAnchor, constant: 0).isActive = true
        WatchedListTableView.trailingAnchor.constraint(equalTo: WatchedView.trailingAnchor, constant: 0).isActive = true
        WatchedListTableView.bottomAnchor.constraint(equalTo: WatchedView.bottomAnchor, constant: 0).isActive = true
    
        MustWatchedListTableView.topAnchor.constraint(equalTo: MustWatchedView.topAnchor, constant: 30).isActive = true
        MustWatchedListTableView.leadingAnchor.constraint(equalTo: MustWatchedView.leadingAnchor, constant: 0).isActive = true
        MustWatchedListTableView.trailingAnchor.constraint(equalTo: MustWatchedView.trailingAnchor, constant: 0).isActive = true
        MustWatchedListTableView.bottomAnchor.constraint(equalTo: MustWatchedView.bottomAnchor, constant: 0).isActive = true
 
        stackView.topAnchor.constraint(equalTo: FavoriteView.safeAreaLayoutGuide.bottomAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        WatchedView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        MustWatchedView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        
        NextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        NextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        NextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        NextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        FavoriteListCollectionView.delegate = self
        FavoriteListCollectionView.dataSource = self
        MustWatchedListTableView.delegate = self
        MustWatchedListTableView.dataSource = self
        WatchedListTableView.delegate = self
        WatchedListTableView.dataSource = self
        getMoviesList()
        
    }
    
    @objc func NextBtn() {
        if setSelectedDataForDetail != nil {
            let Detail = MovieDetailViewController()
            Detail.selectedDataForDetail = self.setSelectedDataForDetail
            self.navigationController?.pushViewController(Detail, animated: true)
        }else {
            let Alert = UIAlertController(title: "Erorr", message: "Please select a Movie.", preferredStyle: .alert)
            Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(Alert, animated: true, completion: nil)
        }
    }
    
    func getMoviesList() {
        APIService().getMoviesList { [self] Response in
            if let response = Response {
                self.MoviesList = response.results
                self.getFavoriteIDsList()
            }else {
                self.showMessage("An error has been occurred", type: .error)
            }
        }
    }
    
    func getFavoriteIDsList() {
        APIService().getFavoritesList { Response in
            if let response = Response {
                self.FavoriteIDs = response.results
                self.SortUpData()
            }else {
                self.showMessage("An error has been occurred", type: .error)
            }
        }
    }
    
    func ActiveNextBtn() {
        UIView.animate(withDuration: 0.5) {
            self.NextButton.backgroundColor = Constants.BackgroundColor.Primary
            self.NextButton.titleLabel?.textColor = .white
        }
    }
    
    func DisableNextBtn() {
        UIView.animate(withDuration: 0.5) {
            self.NextButton.backgroundColor = Constants.BackgroundColor.LightGray
            self.NextButton.titleLabel?.textColor = .lightGray
        }
    }
    
    func SortUpData() {
        WatchedMovies = MoviesList.filter{
            $0.isWatched == true
        }
        
        MustWatchedMovies = MoviesList.filter{
            $0.isWatched == false
        }
        
        for i in 0..<FavoriteIDs.count {
            let FavResult = MoviesList.filter {
                $0.id == FavoriteIDs[i].id
            }
            FavoriteMovies.insert(contentsOf: FavResult, at: 0)
        }
        reloadCollectionViews()
    }
    
    func reloadCollectionViews() {
        DispatchQueue.main.async {
            self.FavoriteListCollectionView.reloadData()
            self.WatchedListTableView.reloadData()
            self.MustWatchedListTableView.reloadData()
        }
    }
}

    
// MARK: UITableViewDelegate, UITableViewDataSource extensions
extension MoviesViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 1 {
            return WatchedMovies.count
        }else if tableView.tag == 2 {
            return MustWatchedMovies.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WatchedMoviesTableViewCell
            cell.title.text = WatchedMovies[indexPath.row].title
            let url = URL(string: Constants.retrievingImageURL + WatchedMovies[indexPath.row].poster_path!)
            
            if WatchedMovies[indexPath.row].IsSelected ?? false == true {
                cell.background.layer.borderWidth = 3
                cell.background.layer.borderColor = Constants.BackgroundColor.Primary.cgColor
                setSelectedDataForDetail = WatchedMovies[indexPath.row]
            }else{
                cell.background.layer.borderColor = UIColor.clear.cgColor
            }
            
            cell.image.kf.setImage(with: url)
            return cell
            
        }else if tableView.tag == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MustWatchMoviesTableViewCell
            cell.title.text = MustWatchedMovies[indexPath.row].title
            let url = URL(string: Constants.retrievingImageURL + MustWatchedMovies[indexPath.row].poster_path!)
            cell.image.kf.setImage(with: url)
            
            if MustWatchedMovies[indexPath.row].IsSelected ?? false == true {
                cell.background.layer.borderWidth = 3
                cell.background.layer.borderColor = Constants.BackgroundColor.Primary.cgColor
                setSelectedDataForDetail = MustWatchedMovies[indexPath.row]
            }else{
                cell.background.layer.borderColor = UIColor.clear.cgColor
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 1 {
            if WatchedMovies[indexPath.row].IsSelected ?? false == true {
                WatchedMovies[indexPath.row].IsSelected = false
                setSelectedDataForDetail = nil
                DisableNextBtn()
            }else {
                setAllArraysFalse()
                WatchedMovies[indexPath.row].IsSelected = true
                ActiveNextBtn()
            }
            reloadCollectionViews()
        }else if tableView.tag == 2 {
            if MustWatchedMovies[indexPath.row].IsSelected ?? false == true {
                MustWatchedMovies[indexPath.row].IsSelected = false
                DisableNextBtn()
                setSelectedDataForDetail = nil
            }else {
                setAllArraysFalse()
                MustWatchedMovies[indexPath.row].IsSelected = true
            }
            reloadCollectionViews()
        }
    }
    
    func setAllArraysFalse() {
    
        for i in 0..<WatchedMovies.count {
            WatchedMovies[i].IsSelected = false
        }
        for i in 0..<MustWatchedMovies.count {
            MustWatchedMovies[i].IsSelected = false
        }
        for i in 0..<FavoriteMovies.count {
            FavoriteMovies[i].IsSelected = false
        }
        
        ActiveNextBtn()
    }
}

// MARK: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource extension
extension MoviesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavoriteMoviesCollectionViewCell
        cell.Title.text = FavoriteMovies[indexPath.row].title
        let url = URL(string: Constants.retrievingImageURL + FavoriteMovies[indexPath.row].poster_path!)
        cell.Image.kf.setImage(with: url)
        if FavoriteMovies[indexPath.row].IsSelected ?? false == true {
            cell.contentView.layer.borderWidth = 3
            cell.contentView.layer.borderColor = Constants.BackgroundColor.Primary.cgColor
            setSelectedDataForDetail = FavoriteMovies[indexPath.row]
        }else{
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width:CGFloat = 0
        if let title = FavoriteMovies[indexPath.row].title {
            width = title.width(withConstrainedHeight: 30, font: Constants.CustomFont.Avenir_Regular_13)
        }
        if width < 70 {
            width = 70
        }
        return CGSize(width:  width + 10, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if FavoriteMovies[indexPath.row].IsSelected ?? false == true {
            FavoriteMovies[indexPath.row].IsSelected = false
            DisableNextBtn()
            setSelectedDataForDetail = nil
        }else {
            setAllArraysFalse()
            FavoriteMovies[indexPath.row].IsSelected = true
            ActiveNextBtn()
        }
        reloadCollectionViews()
    }
}

