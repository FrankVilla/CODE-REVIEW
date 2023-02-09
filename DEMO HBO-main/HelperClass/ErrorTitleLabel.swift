//
//  ErrorTitleLabel.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 26/02/2022.
//

import UIKit

class MovTitleLabel: UILabel {
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(fontSize: CGFloat,alignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = alignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)

    }
    convenience init(fontSize: CGFloat,alignment: NSTextAlignment,weight:UIFont.Weight) {
           self.init(frame: .zero)
           self.textAlignment = alignment
           self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        lineBreakMode = .byTruncatingTail
        textColor = .label
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontForContentSizeCategory = false
        }
}
