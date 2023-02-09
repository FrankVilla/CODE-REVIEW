//
//  QLVGameGuidEventCell.swift
//  Quickline
//
//  Created by Michał Kuleszko on 10.07.2017.
//  Copyright © 2017 DCC Labs Sp. z o.o. All rights reserved.
//

import UIKit
import UIImageViewAlignedSwift

class QLVBaseMosaicEventCell: UICollectionViewCell {
    
    private let titleIdx = 0;
    private let recordingIdx = 1;
    private let liveIdx = 2;
    private let progressIdx = 1;
    
    // Shared:
    @IBOutlet weak var cellStackView: UIStackView?
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var titleStackView: UIStackView?
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var recordingImageView: UIImageView?
    @IBOutlet weak var liveImageView: UIImageView?
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var channelImageView: UIImageViewAligned!
    
    @IBOutlet weak var progressBarView: UIProgressView!
    
    func prepare(event: QLVMedia, showRecording: Bool, showProgess: Bool) {
        let colorScheme = ColorScheme.shared
        
        self.backgroundColor = nil
        
        self.prepareImage(event, colorScheme)
        self.prepareProgressView(event, colorScheme, showProgess)
        self.prepareTitleLabel(event, colorScheme)
        self.prepareRecordingIcon(event, colorScheme, showRecording)
        self.prepareDateLabel(event.startDate, event.endDate, colorScheme)
        self.prepareChannelImage(event.channel.imageURL)
        self.prepareLiveIcon(event)
    }
    
    private func prepareImage(_ event: QLVMedia, _ colorScheme: ColorScheme) {
        if let url = event.imageURL {
            self.image.setImageWith(url, placeholderImage: UIImage(named: "Sports"))
        } else {
            self.image.image = UIImage(named: "Sports")
        }
        self.image.alpha = 1.0
        self.image.backgroundColor = colorScheme.primaryColor().withAlphaComponent(0.6)
    }
    
    private func prepareProgressView(_ event: QLVMedia, _ colorScheme: ColorScheme, _ showProgress: Bool) {
        guard let progressBarView = self.progressBarView else {
            return
        }
        
        let progressView = cellStackView?.arrangedSubviews[progressIdx]
        
        
        if !event.isLiveEvent() || !showProgress {
            progressView?.isHidden = true
            return
        }
        
        progressView?.isHidden = false
        progressBarView.progressTintColor = colorScheme.primaryColor()
        progressBarView.trackTintColor = UIDevice.isPad() ? colorScheme.undefienedColor() : colorScheme.primaryLowAlphaColor()
        progressBarView.progress = Float(NSDate.traxisDatetime().timeIntervalSince(event.startDate) / event.endDate.timeIntervalSince(event.startDate))
    }
    
    private func prepareTitleLabel(_ event: QLVMedia, _ colorScheme: ColorScheme) {
        if let matchData = event.matchData {
            if matchData.isTeamMatch {
                self.title.text = "\(matchData.team1.club.name) : \(matchData.team2.club.name)"
            } else {
                self.title.text = event.title
            }
        } else {
            self.title.text = event.title
        }
        self.title.font = UIFont.customFont(ofSize: QLVMetrics.sportEventsCellFontSize)
        self.title.textColor = colorScheme.textColor()
    }
    
    private func prepareRecordingIcon(_ event: QLVMedia, _ colorScheme: ColorScheme, _ showRecording: Bool) {
            
        if (recordingImageView != nil){
            let recording = titleStackView?.arrangedSubviews[recordingIdx]
            recording?.isHidden = !((event.isRecorded || event.isScheduled) && showRecording)
        }
    }
    
    private func prepareDateLabel(_ startDate: Date, _ endDate: Date, _ colorScheme: ColorScheme) {
        guard let date = self.date else {
            return
        }
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        
        date.text = "\(dateFormatter.string(from: startDate)). \(timeFormatter.string(from: startDate)) - \(timeFormatter.string(from: endDate))"
        date.font = UIFont.customFont(ofSize: QLVMetrics.sportTimeEventsCellFontSize)
        date.textColor = colorScheme.textColor()
    }
    
    private func prepareChannelImage(_ url: URL?) {
        guard let channelImageView = channelImageView else {
            return
        }
        
        if let url = url {
            channelImageView.setImageWith(url)
        } else {
            channelImageView.isHidden = true
        }
    }
    
    private func prepareLiveIcon(_ event: QLVMedia){
        if (liveImageView != nil){
            let liveImage = titleStackView?.arrangedSubviews[liveIdx]
            liveImage?.isHidden = !(event.isLive && event.isLiveEvent())
        }
    }
}
