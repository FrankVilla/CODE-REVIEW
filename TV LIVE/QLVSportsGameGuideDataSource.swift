//
//  QLVSportsGameGuideDataSource.swift
//  Quickline
//
//  Created by Radosław Mariowski on 28/09/2017.
//  Copyright © 2017 DCC Labs Sp. z o.o. All rights reserved.
//

import UIKit

class QLVSportsGameGuideDataSource: QLVUpdateableCollectionViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let controller: QLVSportsGameGuideViewController
    
    init(_ controller: QLVSportsGameGuideViewController) {
        self.controller = controller
        
        super.init(collectionView: controller.collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.createCell(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = self.events[indexPath.item]
        
        if UIDevice.isPad() || !event.isSportMatchEvent() || !event.matchData.isTeamMatch {
            let mediaViewController = QLVMediaViewController(media: event, fromRecordings: false)!
            self.controller.navigationController!.pushViewController(mediaViewController, animated: true)
            
        } else {
            self.controller.performSegue(withIdentifier: "details", sender: self)
        }
    }
    
    func updateEvents(_ channels: [QLVMediaGroup]) {
        self.events = []
        
        for channel in channels {
            self.events += (channel.media as! [QLVMedia])
        }
        
        self.events.sort(by: { $0.startDate < $1.startDate })
        self.updateEventsData()
        
        self.collectionView.reloadData()
    }
}

extension QLVSportsGameGuideDataSource {
    
    fileprivate func createCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! QLVBaseMosaicEventCell
        cell.tag = indexPath.item
        
        if UIDevice.isPhone() {
            cell.frame.origin.x = 0
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
        cell.prepare(event: self.events[indexPath.item], showRecording: false, showProgess: true)
        
        return cell
    }
    
    func setLayout() {
        if UIDevice.isPhone() {
            if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.itemSize = CGSize(width: self.controller.view.bounds.width, height: layout.itemSize.height)
                layout.invalidateLayout()
            }
        }
    }
}

