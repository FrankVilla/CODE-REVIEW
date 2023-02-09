//
//  QLVSportGameDetailsRecommendationsDataSource.swift
//  Quickline
//
//  Created by Radosław Mariowski on 13/09/2017.
//  Copyright © 2017 DCC Labs Sp. z o.o. All rights reserved.
//

import UIKit

class QLVSportGameDetailsRecommendationsDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let controller: QLVSportGameDetailsViewController
    let collectionView: UICollectionView
    var events: [QLVMedia] = []
    
    init(_ controller: QLVSportGameDetailsViewController) {
        self.controller = controller
        self.collectionView = controller.recommendationsCollectionView
        
        super.init()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.createRecomendationCell(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = self.events[indexPath.item]
        let mediaViewController = QLVMediaViewController(media: event, fromRecordings: false)!
        self.controller.navigationController!.pushViewController(mediaViewController, animated: true)
    }
    
    func updateEvents(_ mediaGroups: [QLVMediaGroup]) {
        self.events = [];
        mediaGroups.forEach { mediaGroup in
            self.events += mediaGroup.media as! [QLVMedia]
        }
        self.collectionView.reloadData()
    }
}

extension QLVSportGameDetailsRecommendationsDataSource {
    
    fileprivate func createRecomendationCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! QLVBaseMosaicEventCell
        
        cell.prepare(event: self.events[indexPath.item], showRecording: false, showProgess: false)
        
        if UIDevice.isPhone() {
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
        return cell
    }
}

