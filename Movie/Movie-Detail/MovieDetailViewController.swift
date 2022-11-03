//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by Alireza Namazi on 4/26/22.
//

import UIKit
import SwiftUI

class MovieDetailViewController: UIViewController {
    // MARK: Class props
    var selectedDataForDetail:Movies!
    
    // MARK: connections
    private lazy var Image: UIImageView =  {
     let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 25
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var Background: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = Constants.BackgroundColor.LightGray
        return view
    }()
    
    private lazy var DetailsContent: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = Constants.CustomFont.Avenir_Regular_20
        textView.isEditable = false
        return textView
    }()
    
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
       
    }
}
// MARK: MovieDetailViewController extensions
extension MovieDetailViewController {
    func configureUI() {
        
        navigationItem.title = "Movie Details"
        view.backgroundColor = .white
        view.addSubview(DetailsContent)
        view.addSubview(Background)
        
        Background.addSubview(Image)
        Background.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Background.topAnchor.constraint(equalTo: view.topAnchor,constant: 130).isActive = true
        Background.widthAnchor.constraint(equalToConstant: 70).isActive = true
        Background.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        Image.centerXAnchor.constraint(equalTo: Background.centerXAnchor).isActive = true
        Image.topAnchor.constraint(equalTo: Background.topAnchor, constant: 15).isActive = true
        Image.widthAnchor.constraint(equalToConstant: 50).isActive = true
        Image.heightAnchor.constraint(equalToConstant: 50).isActive = true
       
        DetailsContent.topAnchor.constraint(equalTo: Background.bottomAnchor, constant: 10).isActive = true
        DetailsContent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        DetailsContent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        DetailsContent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        let url = URL(string: Constants.retrievingImageURL + selectedDataForDetail.poster_path!)
        Image.kf.setImage(with: url)
        if let original_title = selectedDataForDetail.original_title, let overview = selectedDataForDetail.overview, let rating = selectedDataForDetail.rating, let release_date = selectedDataForDetail.release_date, let original_language = selectedDataForDetail.original_language {
            
            DetailsContent.text = original_title + "\r\n\(overview) " + "\n\(rating)" +  "\n\(release_date)" + "\n\(original_language)"
            
        }else {
            
            DetailsContent.text = "unfortunately, Data is nil"
            
        }
    }
}
