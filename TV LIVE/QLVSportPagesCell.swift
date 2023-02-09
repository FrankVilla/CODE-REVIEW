//
//  QLVSportPagesCell.swift
//  Quickline
//
//  Created by Radosław Mariowski on 03/07/2017.
//  Copyright © 2017 DCC Labs Sp. z o.o. All rights reserved.
//

import Foundation

class QLVSportPagesCell: UITableViewCell {
    var colorView : UIView?
    
    func prepare(text: String, markAsSelected: Bool) {
        if let textLabel = textLabel {
            textLabel.textColor = ColorScheme.shared.textColor()
            textLabel.font = UIFont.customFont(ofSize: 21)
            textLabel.textAlignment = .center
            textLabel.text = text
        }
        
        self.colorView = UIView(frame: CGRect(x: 0, y: 2, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height - 3))
        self.contentView.addSubview(self.colorView!)
        self.contentView.sendSubviewToBack(self.colorView!)
        
        self.contentView.backgroundColor = UIColor.clear
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.backgroundColor = UIColor.clear
        
        markAsSelected ? self.setAsSelected() : self.setAsUnselected()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textLabel?.frame = CGRect(x: QLVMetrics.menuViewCollectionViewInsetLeft, y: QLVMetrics.menuViewCollectionViewCellContentInsetTop, width: self.frame.size.width - QLVMetrics.menuViewCollectionViewInsetLeft - QLVMetrics.menuViewCollectionViewInsetRight, height: self.frame.size.height - QLVMetrics.menuViewCollectionViewSpacing - QLVMetrics.menuViewCollectionViewCellContentInsetTop);
    }

    func setAsSelected() {
        self.colorView!.backgroundColor = ColorScheme.shared.primaryColor()
    }
    
    func setAsUnselected() {
        self.colorView!.backgroundColor = ColorScheme.shared.primaryLowAlphaColor()
    }
    
    override func prepareForReuse() {
        self.colorView!.backgroundColor = UIColor.clear
    }
}
