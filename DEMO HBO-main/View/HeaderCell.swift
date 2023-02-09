//
//  HeaderCell.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 26/02/2022.
//

import UIKit

protocol HeaderViewCellDelegate: AnyObject {
    func getMoviesButtonPressed(category: MovieCategory)
}

class HeaderCell: UICollectionViewCell {
    static let headerId = "headerId"
    var popularButton =  MovButton(category: .popular)
    var upcomingButton = MovButton(category: .upcoming)
    var topRatedButton = MovButton(category: .top)
    weak var delegate: HeaderViewCellDelegate!
    var selectedCategory:String!
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    func layoutUI() {
        addSubview(stackView)
        popularButton.tag = 0
        upcomingButton.tag = 1
        topRatedButton.tag = 2
        popularButton.backgroundColor = .gray
        popularButton.addTarget(self, action: #selector(categoryButtonPressed), for: .touchUpInside)
        upcomingButton.addTarget(self, action: #selector(categoryButtonPressed), for: .touchUpInside)
        topRatedButton.addTarget(self, action: #selector(categoryButtonPressed), for: .touchUpInside)
        
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        stackView.addArrangedSubview(popularButton)
        stackView.addArrangedSubview(upcomingButton)
        stackView.addArrangedSubview(topRatedButton)
    }
    
    @objc func categoryButtonPressed(sender: UIButton) {
        
        let buttons = [popularButton,upcomingButton,topRatedButton]
        
        for button in buttons {
            button.backgroundColor = .secondarySystemBackground
        }
        
        switch sender.tag {
        case 0:
            delegate.getMoviesButtonPressed(category: MovieCategory.popular)
            popularButton.backgroundColor = .gray
        case 1:
            delegate.getMoviesButtonPressed(category: MovieCategory.upcoming)
            upcomingButton.backgroundColor = .gray
        case 2:
            delegate.getMoviesButtonPressed(category: MovieCategory.top)
            topRatedButton.backgroundColor = .gray
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
