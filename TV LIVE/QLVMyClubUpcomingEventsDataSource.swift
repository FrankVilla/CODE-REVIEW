//
//  QLVMyClubUpcomingEventsDataSource.swift
//  Quickline
//
//  Created by Radosław Mariowski on 04/09/2017.
//  Copyright © 2017 DCC Labs Sp. z o.o. All rights reserved.
//

import UIKit

class QLVMyClubUpcomingEventsDataSource: QLVUpdateableCollectionViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let controller: QLVMyClubViewController
    
    init(_ controller: QLVMyClubViewController) {
        self.controller = controller
        
        super.init(collectionView: controller.upcomingEventsCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.createCell(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.events.count
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
    
    func updateEvents(_ channels: [QLVMediaGroup]?) {
        self.events = []
        self.collectionView.isHidden = true
        
        if let channels = channels {
            for channel in channels {
                let eventsOfChannel = channel.media as! [QLVMedia]
                for event in eventsOfChannel {
                    if event.isFutureEvent() {
                        events.append(event)
                    }
                }
            }
            self.collectionView.isHidden = (events.count == 0)
            
            self.events = self.events.sorted(by: { $0.startDate < $1.startDate })
            super.updateEventsData() // it will reload collection view internally 

            if events.count > 0 {
                if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    if UIDevice.isPad() {
                        let rows: CGFloat = ceil(CGFloat(self.events.count) / 3.0)
                        self.controller.contentHeightConstraint.constant = self.controller.upcomingHighlightsLabel.superview!.frame.origin.y + self.controller.upcomingHighlightsLabel.frame.size.height + (layout.itemSize.height + layout.minimumLineSpacing) * rows
                    } else {
                        self.controller.upcomingEventsCollectionViewHeightConstraint.constant = CGFloat(self.events.count) * (layout.itemSize.height + layout.minimumLineSpacing) + layout.itemSize.height - layout.minimumLineSpacing
                    }
                }
            }
        } else {
            self.collectionView.reloadData()
        }
    }
}

extension QLVMyClubUpcomingEventsDataSource {
    
    fileprivate func createCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! QLVBaseMosaicEventCell
        cell.prepare(event: events[indexPath.item], showRecording: false, showProgess: false)
            
        return cell
    }
    
    func setLayout() {
        if UIDevice.isPhone() {
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.itemSize = CGSize(width: self.collectionView.bounds.width, height: layout.itemSize.height)
                layout.invalidateLayout()
            }
        }
    }
}

