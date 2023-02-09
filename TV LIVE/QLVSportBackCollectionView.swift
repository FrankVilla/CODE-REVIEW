//
//  QLVSportBackCollectionView.swift
//  Quickline
//
//  Created by Kamil Gołuński on 09/01/2018.
//  Copyright © 2018 DCC Labs Sp. z o.o. All rights reserved.
//

import Foundation

class QLVSportBackCollectionView: UICollectionReusableView {
    
    
    @IBOutlet weak var arrowLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func prepare(text: String) {
        titleLabel.textColor = ColorScheme.shared.textColor()
        titleLabel.font = UIFont.customFont(ofSize: UIDevice.isPad() ? 24 : 17)
        titleLabel.textAlignment = .center
        titleLabel.text = "Back".localized
        
        subtitleLabel.textColor = ColorScheme.shared.textColor()
        subtitleLabel.font = UIFont.customFont(ofSize: UIDevice.isPad() ? 12 : 11)
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = "at the beginning".localized
        
        arrowLabel.textColor = ColorScheme.shared.textColor()
        arrowLabel.font = UIFont.iconFont(ofSize: UIDevice.isPad() ? 16 : 12)
        arrowLabel.text = ""
        arrowLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
}
