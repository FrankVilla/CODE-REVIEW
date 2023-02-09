//
//  MovSubtitleLabel.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 26/02/2022.
//

import UIKit

class MovSubtitleLabel: UILabel {
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 15, weight: .light)
        lineBreakMode = .byTruncatingTail
        textColor = .label
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontForContentSizeCategory = false
        }
}
