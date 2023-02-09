//
//  QLVMySportsRecomendationsDataSource.swift
//  Quickline
//
//  Created by Radosław Mariowski on 19/07/2017.
//  Copyright © 2017 DCC Labs Sp. z o.o. All rights reserved.
//

import UIKit

class QLVMySportsRecomendationsDataSource: QLVUpdateableCollectionViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let cellHeightForPhone = 65
    
    let controller: QLVSportsViewController

    init(_ controller: QLVSportsViewController) {
        self.controller = controller
        
        super.init(collectionView: controller.mySportsRecomendationsCollectionView)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.createRecomendationCell(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if UIDevice.isPhone() {
            return self.events.count > 3 ? 3 : self.events.count
        }
        
        return self.events.count > 20 ? 20 : self.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = self.events[indexPath.item]
        let mediaViewController = QLVMediaViewController(media: event, fromRecordings: false)!
        self.controller.navigationController!.pushViewController(mediaViewController, animated: true)
    }
    
    func updateEvents(_ events: [QLVMedia]) {
        self.events = events
    
        super.updateEventsData()
        self.collectionView.reloadData()
        
        if UIDevice.isPhone() {
            self.controller.mySportsRecommendationsViewHeightConstraint.constant = self.controller.mySportsRecommendationsLabel.superview!.bounds.size.height + CGFloat(min(self.events.count, 3) * self.cellHeightForPhone) + 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as? QLVSportBackCollectionView
        footerView?.prepare(text: self.controller.title ?? "All events".localized)
        
        if let recognizers = footerView?.gestureRecognizers {
            for recognizer in recognizers {
                footerView?.removeGestureRecognizer(recognizer)
            }
        }
        
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(backToBeginning))
        footerView?.addGestureRecognizer(gesture)
        
        return footerView!
    }
    
    @objc func backToBeginning(recognizer: UITapGestureRecognizer) {
        self.collectionView.setContentOffset(CGPoint.zero, animated: true)
    }
}

extension QLVMySportsRecomendationsDataSource {
    
    fileprivate func createRecomendationCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! QLVBaseMosaicEventCell
        
        cell.prepare(event: self.events[indexPath.item], showRecording: true, showProgess: false)
        
        if UIDevice.isPhone() {
            cell.frame.origin.x = 0
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
        return cell
    }
    
    func setLayout() {
        if UIDevice.isPhone() {
            if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.itemSize = CGSize(width: self.collectionView.bounds.width, height: layout.itemSize.height)
                layout.invalidateLayout()
            }
        }
    }
}
