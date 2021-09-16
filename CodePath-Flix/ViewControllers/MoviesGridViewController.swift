//
//  MoviesCollectionViewController.swift
//  CodePath-Flix
//
//  Created by Denielle Abaquita on 9/14/21.
//

import UIKit
import AlamofireImage

private enum LayoutConstant {
    static let itemsinRow: CGFloat = 2
    static let spacing: CGFloat = 16.0
    static let itemHeight: CGFloat = 300.0
}

class MoviesGridViewController: UIViewController {

    private var movies = [[String: Any]]()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movies"
        self.navigationController?.navigationBar.isTranslucent = false
        setupURLSession()
        setupCollectionView()
    }
    
    private func setupURLSession() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        let session = URLSession(
            configuration: .default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(
                    with: data,
                    options: []
                ) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String: Any]]
                self.collectionView.reloadData()
            }
        }
        task.resume()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieGridCell.self, forCellWithReuseIdentifier: MovieGridCell.identifier)
        
        // Constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: UICollectionViewDelegate / DataSource
extension MoviesGridViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieGridCell.identifier,
            for: indexPath
        ) as? MovieGridCell else {
            return MovieGridCell()
        }
        
        let movie = movies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        if let posterPath = movie["poster_path"] as? String,
           let posterUrl = URL(string: baseUrl + posterPath) {
            cell.posterImageView.af.setImage(withURL: posterUrl)
        } else {
            cell.posterImageView.image = UIImage(named: "launch_image")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.movie = movies[indexPath.item]
        
        show(movieDetailVC, sender: self)
    }
}

// MARK: CollectionViewDelegateFlowLayout
extension MoviesGridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = itemWidth(for: view.frame.width, spacing: 0)
        return CGSize(width: itemWidth, height: LayoutConstant.itemHeight)
    }
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing = 2 * spacing + (LayoutConstant.itemsinRow - 1) * spacing
        return (width - totalSpacing) / LayoutConstant.itemsinRow - 5.0
    }
}
