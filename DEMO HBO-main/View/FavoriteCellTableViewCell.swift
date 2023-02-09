//
//  FavoriteCellTableViewCell.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 26/02/2022.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseID = "MovieCell"
    let cardView = UIView()
    let movieImage = UIImageView(frame: .zero)
    let movieTitle = MovLabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCardView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureCardView() {
        contentView.addSubview(cardView)
        cardView.layer.cornerRadius = 10
        cardView.layer.masksToBounds = false
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 5, height: 5)
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.masksToBounds = false
        cardView.backgroundColor = .secondarySystemBackground
    }
    
    func configure() {
        cardView.layer.cornerRadius = 10
        cardView.addSubviews(movieImage,movieTitle)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        movieImage.clipsToBounds = true
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.contentMode = .scaleAspectFill
        movieImage.layer.cornerRadius = 10
        movieImage.layer.masksToBounds = true
        movieTitle.clipsToBounds = true
        movieTitle.layer.cornerRadius = 10
        movieTitle.backgroundColor = .secondarySystemBackground
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 200),
            movieImage.topAnchor.constraint(equalTo: cardView.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 150),
            movieTitle.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            movieTitle.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            movieTitle.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func set(movie: Movie) {
        movieTitle.text = movie.title
        let imagePath = movie.posterPath != nil ? movie.backdropPath : movie.posterPath
        
        NetworkManager.shared.getMovieImage(posterPath: imagePath!) { (image) in
            if image != nil {
                DispatchQueue.main.async {
                    self.movieImage.image = image
                }
            }
            else {
                DispatchQueue.main.async {
                    self.movieImage.image = UIImage(named: "placeholder.jpg")
                    self.movieTitle.text = movie.title
                }
            }
        }
    }
}

