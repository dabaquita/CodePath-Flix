//
//  MovieGridCell.swift
//  CodePath-Flix
//
//  Created by Denielle Abaquita on 9/16/21.
//

import UIKit

class MovieGridCell: UICollectionViewCell {
    
    static let identifier = "MovieGridCell"
    var posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurePosterImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePosterImageView() {
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
