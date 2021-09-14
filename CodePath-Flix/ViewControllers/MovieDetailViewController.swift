//
//  MovieDetailViewController.swift
//  CodePath-Flix
//
//  Created by Denielle Abaquita on 9/12/21.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: UIViewController {
    
    var movie: [String: Any]!
    
    var headerImageView = UIImageView()
    var posterImageView = UIImageView()
    var overviewLabel = UILabel()
    var titleDateStackView = UIStackView()
    var titleLabel = UILabel()
    var dateLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationController?.navigationBar.isTranslucent = false
        
        // Set up subviews
        view.addSubview(headerImageView)
        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.addSubview(overviewLabel)
        
        setupHeaderImageView()
        setupPosterImageView()
        setupTitleLabel()
        setupDateLabel()
        setupOverviewLabel()
    }
    
    func setupHeaderImageView() {
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: baseUrl + backdropPath)
        if let backdropURL = backdropURL {
            headerImageView.af.setImage(withURL: backdropURL)
        } else {
            headerImageView.image = UIImage(named: "launch_image")
        }
        headerImageView.contentMode = .scaleAspectFill
        
        // Constraints
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        headerImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        headerImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -3 * view.bounds.height / 5).isActive = true
    }
    
    func setupPosterImageView() {
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        if let posterUrl = posterUrl {
            posterImageView.af.setImage(withURL: posterUrl)
        } else {
            posterImageView.image = UIImage(named: "launch_image")
        }
        posterImageView.contentMode = .scaleAspectFill
        
        // Constraints
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: -135).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -300).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -600).isActive = true
    }
    
    func setupTitleLabel() {
        titleLabel.text = movie["title"] as? String
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        // Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 6).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 24).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
    }
    
    func setupDateLabel() {
        dateLabel.text = movie["release_date"] as? String
        dateLabel.font = .systemFont(ofSize: 17)
        dateLabel.textColor = .white
        dateLabel.numberOfLines = 1
        
        // Constraints
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    }
    
    func setupOverviewLabel() {
        overviewLabel.text = movie["overview"] as? String
        overviewLabel.font = .systemFont(ofSize: 17)
        overviewLabel.textColor = .white
        overviewLabel.textAlignment = .left
        overviewLabel.numberOfLines = 0
        
        // Constraints
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        overviewLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 12).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
    }

}
