//
//  FavoritesViewController.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 26/02/2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var tableView = UITableView()
    var favorites : [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getFavorites()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(true)

       }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()

    }

    func configureViewController() {
        title = "Favorite Movies"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        self.tableView.rowHeight = 220
        tableView.pinToEdges(of: view)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    func getFavorites() {
        PersistenceManager.retrieveFavorites {[weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let favorites):
                self.favorites = favorites
                self.tableView.reloadData()

            case .failure(let error):
                self.presentAlert(withTitle: error.rawValue, message: "Favorites option is not enabled")
            }
        }
    }
}

extension FavoritesViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        cell.set(movie: favorites[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else {return}
        
            PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { (error) in
                if let _ = error {
                    self.presentAlert(withTitle: error!.rawValue, message: "Favorites option is not enabled")
                    return
                }

                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}

extension FavoritesViewController {
   func presentAlert(withTitle title: String, message : String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { action in}
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}
