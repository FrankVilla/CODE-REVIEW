//
//  MovBodyLabel.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 26/02/2022.
//

import UIKit

class MovBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(textAlignment: NSTextAlignment){
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        lineBreakMode = .byTruncatingTail
        numberOfLines = 0
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontForContentSizeCategory = true
    }
}
