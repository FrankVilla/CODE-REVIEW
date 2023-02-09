//
//  MovButton.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 26/02/2022.
//

import UIKit

class MovButton: UIButton {
    var category : MovieCategory!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(category: MovieCategory) {
        self.init(frame: .zero)
        setTitle(category.rawValue, for: .normal)
        setTitleColor(.label, for: .normal)
        self.category = category
        backgroundColor = .secondarySystemBackground

    }
    convenience init(title: String, backgroundColor: UIColor) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    func configure() {
       titleLabel?.textAlignment = .center
       layer.cornerRadius = 10
       titleLabel?.font = UIFont(name: "Montserrat", size: 17)
       translatesAutoresizingMaskIntoConstraints = false
    }
}
