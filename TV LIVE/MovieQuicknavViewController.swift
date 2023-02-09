//
//  MovieQuicknavViewController.swift
//  Quickline
//
//  Created by Kristaps Freibergs on 27/10/2018.
//  Copyright © 2018 Ambrite Latvia. All rights reserved.
//

import Foundation

private let headerTextSize : CGFloat = UIDevice.isPad() ? 21 : 17
private let sectionInset : Int = UIDevice.isPad() ? 15 : 10


class MovieQuicknavViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var viewModel : MovieQuicknavViewModel?
    @IBOutlet weak var collectionView: UICollectionView?
    
    @objc func setViewModel(viewModel: MovieQuicknavViewModel){
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let seperatorWidth = 3 * ((viewModel?.titles.count)!-1)
        let iPadSpareWidth = view.frame.size.width - CGFloat(sectionInset*2 + seperatorWidth)
        
        let width = UIDevice.isPad() ? iPadSpareWidth/CGFloat((viewModel?.titles.count)!) : 110
        return CGSize(width: width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: CGFloat(sectionInset), bottom: 0, right: CGFloat(sectionInset))
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.titles.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! QuicnavCell
        cell.title?.text = viewModel?.titles[indexPath.row]
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.selectedItem(index: indexPath.row)
    }
}


class QuicnavCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let color = ColorScheme.shared
        contentView.backgroundColor = color.supportingColor()
        title?.textColor = color.textColor()
        title?.font = UIFont.customFont(ofSize: headerTextSize)
    }
}
