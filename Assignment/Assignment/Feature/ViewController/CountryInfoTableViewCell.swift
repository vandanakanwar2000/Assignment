//
//  CountryInfoTableViewCell.swift
//  Assignment
//
//  Created by Vandana Kanwar on 16/5/20.
//  Copyright © 2020 Vandana Kanwar. All rights reserved.
//

import UIKit

class CountryInfoTableViewCell: UITableViewCell {
    let padding: CGFloat = 16.0
    let nameLabel = UILabel()
    let detailLabel = UILabel()
    let profileImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        profileImageView.isHidden = true
        
        detailLabel.numberOfLines = 0
        detailLabel.font =  UIFont.preferredFont(forTextStyle: .subheadline)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, profileImageView, detailLabel])
        stackView.axis = .vertical
        stackView.spacing = padding
        
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ detail: Details? = nil, _ image: UIImage? = nil) {
        nameLabel.text = detail?.title
        detailLabel.text = detail?.description
        update(image: image)
    }
    
    private func update(image: UIImage?) {
        guard let img = image
            else {
                profileImageView.isHidden = true
                return
        }
        profileImageView.isHidden = false
        profileImageView.image = img
        
    }
}
