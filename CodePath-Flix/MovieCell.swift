//
//  MovieCell.swift
//  CodePath-Flix
//
//  Created by Denielle Abaquita on 9/6/21.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let identifier = "MovieCell"
    var thumbnailView = UIImageView()
    var stackView = UIStackView()
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(thumbnailView)
        addSubview(stackView)
        
        configureThumbnailView()
        setThumbnailImageContraints()
        
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure Views
    private func configureThumbnailView() {
        thumbnailView.layer.cornerRadius = 10
        thumbnailView.clipsToBounds = true
        thumbnailView.contentMode = .scaleAspectFill
    }
    
    private func configureStackView() {
        // Subviews setup
        configureTitleLabel()
        configureDescriptionLabel()
        
        // Stackview setup
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        setStackViewConstraints()
    }
    
    private func configureTitleLabel() {
        titleLabel.numberOfLines = 1
        titleLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.numberOfLines = 3
        descriptionLabel.font = descriptionLabel.font.withSize(15)
    }
    
    // MARK: Constraints
    private func setThumbnailImageContraints() {
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        thumbnailView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        thumbnailView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        thumbnailView.widthAnchor.constraint(equalTo: thumbnailView.heightAnchor).isActive = true
    }
    
    private func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 12).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}
