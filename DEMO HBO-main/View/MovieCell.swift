//
//  MovieCell.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 26/02/2022.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let reuseID = "MovieCell"
    let movieImage = UIImageView(image: UIImage(named: "placeholder.jpg"))
    var movieNameLabel = MovTitleLabel(fontSize: 16, alignment: .center,weight: .light)
    let cardView = UIView()
    let padding : CGFloat = 10
    var watchingButton = UIButton(frame: CGRect(x: 150, y: 0, width: 30, height: 30))
    var subscribeButtonAction : (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCardView()
        configureMovieImage()
        configureNameLabel()
        configureWatchButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWatchButton() {
        addSubview(watchingButton)
        watchingButton.tintColor = .red
        watchingButton.setBackgroundImage(UIImage(systemName: "play.rectangle.on.rectangle"), for: .normal)
        watchingButton.setBackgroundImage(UIImage(systemName: "play.rectangle.on.rectangle.fill"), for: .selected)
        watchingButton.addTarget(self, action: #selector(performTask), for: .touchUpInside)
    }
    
    @objc func performTask(){
        if watchingButton.isSelected == true {
           watchingButton.isSelected = false
           movieNoWatched()
    } else {
           watchingButton.isSelected = true
           movieWatched()
        }
    }
   
    override func prepareForReuse() {
        watchingButton.isSelected = false
    }
    
    func set(movie: Movie) {
        NetworkManager.shared.getMovieImage(posterPath: movie.posterPath!) {[weak self] (image) in
            guard let self = self else {return}
            if image != nil {
                self.updateUI(image: image!,title: movie.title)
            } else  {
                self.setMock(movie: movie)
            }
        }
    }
    
    func setMock(movie : Movie) {
        DispatchQueue.main.async {
            self.movieImage.image = UIImage(named: "placeholder.jpg")
            self.movieNameLabel.text = "Test"
        }
    }
    
    func updateUI(image: UIImage,title: String) {
        DispatchQueue.main.async {
            self.movieImage.image = image
            self.movieNameLabel.text = title
        }
    }
    
    func configureCardView() {
        addSubview(cardView)
        cardView.layer.cornerRadius = 15
        cardView.layer.masksToBounds = false
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 5, height: 5)
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.masksToBounds = false
        cardView.backgroundColor = .secondarySystemBackground
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            cardView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
        ])
    }
    
    func configureMovieImage() {
        cardView.addSubview(movieImage)
        movieImage.layer.masksToBounds = true
        movieImage.layer.cornerRadius = 15
        movieImage.contentMode = .scaleToFill
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: cardView.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 270),
        ])
    }
    
    func configureNameLabel(){
        cardView.addSubview(movieNameLabel)
        movieNameLabel.layer.cornerRadius = 10
        movieNameLabel.layer.masksToBounds = true
        movieNameLabel.numberOfLines = 2
        movieNameLabel.backgroundColor = .secondarySystemBackground
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor),
            movieNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor,constant: -5),
            movieNameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 5),
            movieNameLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func movieWatched(){
        let alert = UIAlertController(title: "Movie Watched", message: "You have selected this movie as already watched.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    func movieNoWatched(){
        let alert = UIAlertController(title: "Movie no Watched", message: "You have selected this movie as not watched", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
