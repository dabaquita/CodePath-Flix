//
//  ViewController.swift
//  CodePath-Flix
//
//  Created by Denielle Abaquita on 9/1/21.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var movies = [[String: Any]]()
    let tableView = UITableView()
    
    // MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        self.setupURLSession()
        self.setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: URL Session
    private func setupURLSession() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    // MARK: TableView
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        cell.textLabel?.text = "Movie \(indexPath.row + 1): \(title)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Cell tapped")
    }
}

