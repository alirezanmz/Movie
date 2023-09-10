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
    
    // MARK: - Class Properties
    var moviesList: [Movies] = []
    var favoriteMovies: [Movies] = []
    var watchedMovies: [Movies] = []
    var mustWatchedMovies: [Movies] = []
    var favoriteIDs: [Favorite] = []
    var selectedDataForDetail: Movies?
    var setSelectedDataForDetail:Movies?
    private let apiService: APIService
    
    // MARK: - Initializer
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: connections
    private lazy var layout: UICollectionViewFlowLayout = {
       let collectionViewFlowLayout = UICollectionViewFlowLayout()
          collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
          collectionViewFlowLayout.minimumInteritemSpacing = 20
          collectionViewFlowLayout.minimumLineSpacing = 26
          collectionViewFlowLayout.scrollDirection = .horizontal
        return collectionViewFlowLayout
    }()
   
    var favoriteListCollectionView: UICollectionView!
    
    private lazy var mustWatchedListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(MustWatchMoviesTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.tag = 2
        return tableView
    }()
    
    private lazy var watchedListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(WatchedMoviesTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tag = 1
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var nextButton: UIButton = {
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
    
    private lazy var favoriteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var watchedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var mustWatchedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var favoriteTopicName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 10, y: 0, width: 200, height: 30)
        label.textColor = .lightGray
        label.font = UIFont(name: "Avenir-Book", size: 25)
        label.text = "Favorites"
        return label
    }()
    
    private lazy var watchedTopicName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 10, y: 0, width: 200, height: 30)
        label.frame = CGRect(x: 10, y: 0, width: 200, height: 30)
        label.textColor = .lightGray
        label.font = UIFont(name: "Avenir-Book", size: 25)
        label.text = "Watched"
        return label
    }()
    
    private lazy var mustWatchedTopicName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 10, y: 0, width: 200, height: 30)
        label.frame = CGRect(x: 10, y: 0, width: 200, height: 30)
        label.textColor = .lightGray
        label.font = UIFont(name: "Avenir-Book", size: 25)
        label.text = "Must watch"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        setDelegates()
        fetchMoviesList()
    }
}

// MARK: MoviesViewController extensions
extension MoviesViewController {
    // MARK: Class methods
    private func configureUI() {
        setupFavoriteView()
        setupStackView()
        setupWatchedView()
        setupMustWatchedView()
        setupNextButton()
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: favoriteView.safeAreaLayoutGuide.bottomAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }

    private func setupFavoriteView() {
        // Configure the FavoriteView and its subviews
        favoriteView.addSubview(favoriteTopicName)
        favoriteListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        favoriteListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        favoriteListCollectionView.register(FavoriteMoviesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        favoriteListCollectionView.showsHorizontalScrollIndicator = false
        
        favoriteView.addSubview(favoriteListCollectionView)
        
        navigationItem.title = "Movies App"
        view.backgroundColor = .white
        view.addSubview(favoriteView)
        
        favoriteView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        favoriteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        favoriteView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        favoriteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true

        favoriteListCollectionView.topAnchor.constraint(equalTo: favoriteView.topAnchor, constant: 30).isActive = true
        favoriteListCollectionView.leadingAnchor.constraint(equalTo: favoriteView.leadingAnchor, constant: 0).isActive = true
        favoriteListCollectionView.trailingAnchor.constraint(equalTo: favoriteView.trailingAnchor, constant: 0).isActive = true
        favoriteListCollectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        
    }

    private func setupWatchedView() {
        // Configure the WatchedView and its subviews
      
        watchedView.addSubview(watchedTopicName)
        watchedView.addSubview(watchedListTableView)
        stackView.addArrangedSubview(watchedView)
        watchedView.addSubview(watchedListTableView)
        watchedListTableView.topAnchor.constraint(equalTo: watchedView.topAnchor, constant: 30).isActive = true
        watchedListTableView.leadingAnchor.constraint(equalTo: watchedView.leadingAnchor, constant: 0).isActive = true
        watchedListTableView.trailingAnchor.constraint(equalTo: watchedView.trailingAnchor, constant: 0).isActive = true
        watchedListTableView.bottomAnchor.constraint(equalTo: watchedView.bottomAnchor, constant: 0).isActive = true
    
        watchedView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    
    }

    private func setupMustWatchedView() {
        // Configure the MustWatchedView and its subviews
        stackView.addArrangedSubview(mustWatchedView)
        mustWatchedView.addSubview(mustWatchedTopicName)
        mustWatchedView.addSubview(mustWatchedListTableView)
        mustWatchedListTableView.topAnchor.constraint(equalTo: mustWatchedView.topAnchor, constant: 30).isActive = true
        mustWatchedListTableView.leadingAnchor.constraint(equalTo: mustWatchedView.leadingAnchor, constant: 0).isActive = true
        mustWatchedListTableView.trailingAnchor.constraint(equalTo: mustWatchedView.trailingAnchor, constant: 0).isActive = true
        mustWatchedListTableView.bottomAnchor.constraint(equalTo: mustWatchedView.bottomAnchor, constant: 0).isActive = true
        mustWatchedView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    }

    private func setupNextButton() {
        // Configure the NextButton
        view.addSubview(nextButton)
        
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
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
    

    func fetchMoviesList() {
          apiService.getMoviesList { [weak self] response in
              guard let strongSelf = self else { return }
              if let response = response {
                  strongSelf.moviesList = response.results
                  strongSelf.fetchFavoriteIDsList()
              } else {
                  strongSelf.showMessage("An error has occurred", type: .error)
              }
          }
      }
    
    func fetchFavoriteIDsList() {
        apiService.getFavoritesList { [weak self]  Response in
            guard let strongSelf = self else { return }
            if let response = Response {
                strongSelf.favoriteIDs = response.results
                strongSelf.SortUpData()
            }else {
                strongSelf.showMessage("An error has been occurred", type: .error)
            }
        }
    }
    
    func ActiveNextBtn() {
        UIView.animate(withDuration: 0.5) {
            self.nextButton.backgroundColor = Constants.BackgroundColor.Primary
            self.nextButton.titleLabel?.textColor = .white
        }
    }
    
    func DisableNextBtn() {
        UIView.animate(withDuration: 0.5) {
            self.nextButton.backgroundColor = Constants.BackgroundColor.LightGray
            self.nextButton.titleLabel?.textColor = .lightGray
        }
    }
    
    func SortUpData() {
        watchedMovies = moviesList.filter{
            $0.isWatched == true
        }
        
        mustWatchedMovies = moviesList.filter{
            $0.isWatched == false
        }
        
        for i in 0..<favoriteIDs.count {
            let FavResult = moviesList.filter {
                $0.id == favoriteIDs[i].id
            }
            favoriteMovies.insert(contentsOf: FavResult, at: 0)
        }
        reloadCollectionViews()
    }
    
    func reloadCollectionViews() {
        DispatchQueue.main.async {
            self.favoriteListCollectionView.reloadData()
            self.watchedListTableView.reloadData()
            self.mustWatchedListTableView.reloadData()
        }
    }
    
    private func createTableView(tag: Int) -> UITableView {
           let tableView = UITableView()
           tableView.translatesAutoresizingMaskIntoConstraints = false
           tableView.backgroundColor = .white
           tableView.separatorStyle = .none
           tableView.tag = tag
           return tableView
       }
    
    private func setDelegates() {
        favoriteListCollectionView.delegate = self
        favoriteListCollectionView.dataSource = self
        mustWatchedListTableView.delegate = self
        mustWatchedListTableView.dataSource = self
        watchedListTableView.delegate = self
        watchedListTableView.dataSource = self
     }
}

    
// MARK: UITableViewDelegate, UITableViewDataSource extensions
extension MoviesViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 1 {
            return watchedMovies.count
        }else if tableView.tag == 2 {
            return mustWatchedMovies.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WatchedMoviesTableViewCell
            cell.title.text = watchedMovies[indexPath.row].title
            let url = URL(string: Constants.retrievingImageURL + watchedMovies[indexPath.row].poster_path!)
            
            if watchedMovies[indexPath.row].isSelected ?? false == true {
                cell.background.layer.borderWidth = 3
                cell.background.layer.borderColor = Constants.BackgroundColor.Primary.cgColor
                setSelectedDataForDetail = watchedMovies[indexPath.row]
            }else{
                cell.background.layer.borderColor = UIColor.clear.cgColor
            }
            
            cell.image.kf.setImage(with: url)
            return cell
            
        }else if tableView.tag == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MustWatchMoviesTableViewCell
            cell.title.text = mustWatchedMovies[indexPath.row].title
            let url = URL(string: Constants.retrievingImageURL + mustWatchedMovies[indexPath.row].poster_path!)
            cell.image.kf.setImage(with: url)
            
            if mustWatchedMovies[indexPath.row].isSelected ?? false == true {
                cell.background.layer.borderWidth = 3
                cell.background.layer.borderColor = Constants.BackgroundColor.Primary.cgColor
                setSelectedDataForDetail = mustWatchedMovies[indexPath.row]
            }else{
                cell.background.layer.borderColor = UIColor.clear.cgColor
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 1 {
            if watchedMovies[indexPath.row].isSelected ?? false == true {
                watchedMovies[indexPath.row].isSelected = false
                setSelectedDataForDetail = nil
                DisableNextBtn()
            }else {
                setAllArraysFalse()
                watchedMovies[indexPath.row].isSelected = true
                ActiveNextBtn()
            }
            reloadCollectionViews()
        }else if tableView.tag == 2 {
            if mustWatchedMovies[indexPath.row].isSelected ?? false == true {
                mustWatchedMovies[indexPath.row].isSelected = false
                DisableNextBtn()
                setSelectedDataForDetail = nil
            }else {
                setAllArraysFalse()
                mustWatchedMovies[indexPath.row].isSelected = true
            }
            reloadCollectionViews()
        }
    }
    
    func setAllArraysFalse() {
    
        for i in 0..<watchedMovies.count {
            watchedMovies[i].isSelected = false
        }
        for i in 0..<mustWatchedMovies.count {
            mustWatchedMovies[i].isSelected = false
        }
        for i in 0..<favoriteMovies.count {
            favoriteMovies[i].isSelected = false
        }
        
        ActiveNextBtn()
    }
}

// MARK: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource extension
extension MoviesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavoriteMoviesCollectionViewCell
        cell.Title.text = favoriteMovies[indexPath.row].title
        let url = URL(string: Constants.retrievingImageURL + favoriteMovies[indexPath.row].poster_path!)
        cell.Image.kf.setImage(with: url)
        
        if favoriteMovies[indexPath.row].isSelected ?? false == true {
            cell.contentView.layer.borderWidth = 3
            cell.contentView.layer.borderColor = Constants.BackgroundColor.Primary.cgColor
            setSelectedDataForDetail = favoriteMovies[indexPath.row]
        }else{
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width:CGFloat = 0
        if let title = favoriteMovies[indexPath.row].title {
            width = title.width(withConstrainedHeight: 30, font: Constants.CustomFont.Avenir_Regular_13)
        }
        if width < 70 {
            width = 70
        }
        return CGSize(width:  width + 10, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if favoriteMovies[indexPath.row].isSelected ?? false == true {
            favoriteMovies[indexPath.row].isSelected = false
            DisableNextBtn()
            setSelectedDataForDetail = nil
        }else {
            setAllArraysFalse()
            favoriteMovies[indexPath.row].isSelected = true
            ActiveNextBtn()
        }
        reloadCollectionViews()
    }
}

