//
//  WatchedMoviesTableViewCell.swift
//  Movie
//
//  Created by Alireza Namazi on 4/25/22.
//

import UIKit

class WatchedMoviesTableViewCell: UITableViewCell {
    lazy var background:UIView = {
      let background = UIView()
       background.translatesAutoresizingMaskIntoConstraints = false
       background.backgroundColor = Constants.BackgroundColor.LightGray
       background.layer.cornerRadius = 5
      return background
   }()
   lazy var image: UIImageView = {
      let image = UIImageView()
       image.translatesAutoresizingMaskIntoConstraints = false
       image.widthAnchor.constraint(equalToConstant: 35).isActive = true
       image.heightAnchor.constraint(equalToConstant: 35).isActive = true
       image.layer.cornerRadius = 15
       image.layer.masksToBounds = true
       image.contentMode = .scaleAspectFill
       return image
   }()
    lazy var title:UILabel = {
       let title = UILabel()
       title.translatesAutoresizingMaskIntoConstraints = false
       title.numberOfLines = 0
       title.font = Constants.CustomFont.Avenir_Regular_20
       return title
   }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    private func configureUI() {
        background.addSubview(title)
        contentView.addSubview(background)
        background.addSubview(image)
        let marginGuide = contentView.layoutMarginsGuide

        title.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor,constant: 50).isActive = true
        title.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: 0).isActive = true
        title.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        title.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 5).isActive = true

        background.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        background.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        background.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        
        image.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: leftAnchor,constant: 20).isActive = true
        image.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        
        selectionStyle = .none
        backgroundColor = .clear
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
