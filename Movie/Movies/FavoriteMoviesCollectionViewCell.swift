//
//  FavoriteMoviesCollectionViewCell.swift
//  Movie
//
//  Created by Alireza Namazi on 4/24/22.
//

import UIKit

class FavoriteMoviesCollectionViewCell: UICollectionViewCell {
    
    lazy var Title: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Constants.CustomFont.Avenir_Regular_13
        return label
    }()
    lazy var Image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 25
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        contentView.addSubview(Title)
        contentView.addSubview(Image)
        Title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        Title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 5).isActive = true
        Title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: -5).isActive = true
        Title.heightAnchor.constraint(equalToConstant: 30).isActive = true

        Image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        Image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        Image.widthAnchor.constraint(equalToConstant: 50).isActive = true
        Image.heightAnchor.constraint(equalToConstant: 50).isActive = true
        layer.cornerRadius = 5
        contentView.backgroundColor = Constants.BackgroundColor.LightGray
        layer.masksToBounds = true
    }
}
