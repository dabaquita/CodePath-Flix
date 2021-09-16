//
//  MoviesCollectionViewController.swift
//  CodePath-Flix
//
//  Created by Denielle Abaquita on 9/14/21.
//

import UIKit

class MoviesGridViewController: UIViewController {

    var movies = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Superhero"
        setupURLSession()
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
                print(self.movies)
            }
        }
        task.resume()
    }
    
    private func setupCollectionView() {
        
    }
    
}
