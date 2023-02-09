//
//  MoviesViewController.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 26/02/2022.
//

import UIKit

class MoviesViewController: DataLoading {
    
    enum Section {
        case main
    }
    
    var collectionView: UICollectionView!
    let searchController = UISearchController()
    var allMovies : [Movie] = []
    var filteredMovies : [Movie] = []
    let scrollView = UIScrollView()
    let contentView = UIView()
    let imageView = UIView()
    let image2 = UIView()
    var headerCell = HeaderCell()
    var dataSource: UICollectionViewDiffableDataSource<Section,Movie>!
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular Movies"
        networkMonitor()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        getMovies(category: .popular)
    }
    
    func networkMonitor() {
        if NetworkMonitor.shared.isConnetcted {
            print("Network isConnetcted")
        }
        else {
            presentAlert(withTitle: "Error Network", message: "You lost network connection")
        }
    }
    
    func getMovies(category: MovieFilter) {
        showSpinner()
        NetworkManager.shared.getMovies(category: category) {[weak self] (result) in
            guard let self = self else {return}
            self.removeSpinner()
            switch result {
            case .failure(let error): 
                self.presentAlert(withTitle: error.rawValue, message: "An unexpected error has occurred")
            case .success(let movies):
                self.allMovies = movies
                DispatchQueue.main.async {
                    self.updateData(on: self.allMovies)
                }
            }
        }
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a movie"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createTwoColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.height-100),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func updateData(on movies: [Movie]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Movie>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            cell.set(movie: movie)
        
            return cell
        })
     
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCell.headerId, for: indexPath) as? HeaderCell else {
                fatalError("Could not dequeue sectionHeader: \(HeaderCell.headerId)")
            }
            sectionHeader.delegate = self
            
            return sectionHeader
        }
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else  {
            filteredMovies.removeAll()
            updateData(on: allMovies)
            isSearching = false
            return
        }
        isSearching = true
        filteredMovies = allMovies.filter({ (movie) in
            movie.title.lowercased().contains(filter.lowercased())
            
        })
        updateData(on: filteredMovies)
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = isSearching ? filteredMovies[indexPath.row] : allMovies[indexPath.row]
        let destVC = MovieDetailViewController(movie: movie)
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind:
        String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:
            "headerId", for: indexPath) as! HeaderCell
        headerCell.delegate = self
        return headerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
}

    func createTwoColumnFlowLayout(in view:UIView) -> UICollectionViewLayout {
    let width                   = view.bounds.width
    let padding: CGFloat        = 12
    let minItemSpacing: CGFloat = 30
    let availableWidth          = width-(2*padding)-(minItemSpacing)
    let itemWidth               = availableWidth/2
    let flowLayout              = UICollectionViewFlowLayout()
    flowLayout.minimumLineSpacing = 30
    flowLayout.sectionInset     = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize         = CGSize(width: itemWidth, height: itemWidth+135)
    return flowLayout
    
}

extension MoviesViewController: HeaderViewCellDelegate {
    func getMoviesButtonPressed(category: MovieCategory) {
        switch category {
        case .top:
            self.getMovies(category: .top)
        case .popular:
            self.getMovies(category: .popular)
        case .upcoming:
            self.getMovies(category: .upcoming)
        }
        self.title! = category.rawValue + " Movies"
    }
}

extension MoviesViewController {
   func presentAlert(withTitle title: String, message : String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { action in}
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}
