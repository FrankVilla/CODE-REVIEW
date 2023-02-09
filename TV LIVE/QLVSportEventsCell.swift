//
//  QLVSportEventsCell.swift
//  Quickline
//
//  Created by Radosław Mariowski on 11/07/2017.
//  Copyright © 2017 DCC Labs Sp. z o.o. All rights reserved.
//

import Foundation
import UIImageViewAlignedSwift

class QLVSportEventsCell: UITableViewCell {
    
    private let titleIdx = 0;
    private let recordingIdx = 1;
    private let liveIdx = 2;

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var teamsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var channelImageView: UIImageViewAligned!
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var recordIcon: UILabel!
    
    @IBOutlet weak var titleStackView: UIStackView?
    @IBOutlet weak var recordingImageView: UIImageView?
    @IBOutlet weak var liveImageView: UIImageView?
    
    func prepare(event: QLVMedia) {
        let colorScheme = ColorScheme.shared
        self.backgroundColor = colorScheme.undefienedColor()
        
        self.prepareTitleLabel(event, colorScheme)
        self.prepareTeamsLabel(event.matchData, colorScheme)
        self.prepareTimeLabel(event.startDate, event.endDate, colorScheme)
        self.prepareProgressBar(event, colorScheme)
        self.prepareRecordIcon(event, colorScheme)
        self.prepareChannelImageView(event.channel.imageURL)
        self.prepareLiveIcon(event)
        
        self.layoutIfNeeded()
    }
    
    private func prepareRecordIcon(_ event: QLVMedia, _ colorScheme: ColorScheme) {
        
        guard let recordingIcon = recordIcon else {
            
            if (recordingImageView != nil){
                let recording = titleStackView?.arrangedSubviews[recordingIdx]
                recording?.isHidden = !(event.isRecorded || event.isScheduled)
            }
            return;
        }
        
        
        if event.isRecorded || event.isRecording() || event.isScheduled {
            recordingIcon.attributedText = NSAttributedString.recordIcon(30.0, colorScheme)
            
            recordingIcon.isHidden = false
        } else {
            recordingIcon.isHidden = true
        }
    }
    
    private func prepareTitleLabel(_ event: QLVMedia, _ colorScheme: ColorScheme) {
        if let matchData = event.matchData {
            self.titleLabel.text = matchData.isTeamMatch ? matchData.league : event.title
        } else {
            self.titleLabel.text = event.title
        }
        self.titleLabel.font = UIFont.customFont(ofSize: QLVMetrics.sportEventsCellFontSize)
        self.titleLabel.textColor = colorScheme.textColor()
    }
    
    private func prepareTeamsLabel(_ matchData: QLVMySportsMatchData?, _ colorScheme: ColorScheme) {
        if let matchData = matchData {
            if matchData.isTeamMatch {
                self.teamsLabel.isHidden = false
                self.teamsLabel.text = "\(matchData.team1.club.name) : \(matchData.team2.club.name)";
                self.teamsLabel.font = UIFont.customFont(ofSize: QLVMetrics.sportEventsCellFontSize)
                self.teamsLabel.textColor = colorScheme.textColor()
            } else {
                self.teamsLabel.isHidden = true
            }
        } else {
            self.teamsLabel.isHidden = true
            self.teamsLabel.text = "";
        }
    }
    
    private func prepareTimeLabel(_ startDate: Date, _ endDate: Date, _ colorScheme: ColorScheme) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let text = "\(formatter.string(from: startDate))-\(formatter.string(from: endDate))"
        self.timeLabel.text = text
        self.timeLabel.font = UIFont.customFont(ofSize: QLVMetrics.sportTimeEventsCellFontSize)
        self.timeLabel.textColor = colorScheme.textColor()
    }
    
    private func prepareProgressBar(_ event: QLVMedia, _ colorScheme: ColorScheme) {
        self.progressBarView.progressTintColor = colorScheme.primaryColor()
        self.progressBarView.trackTintColor = colorScheme.primaryLowAlphaColor()
        self.progressBarView.progress = Float(event.progress())
    }
    
    private func prepareChannelImageView(_ url: URL?) {
        if let url = url {
            self.channelImageView.setImageWith(url)
        } else {
            self.channelImageView.isHidden = true
        }
    }
    
    private func prepareLiveIcon(_ event: QLVMedia){
        if (liveImageView != nil){
            let index = recordingImageView != nil ? liveIdx : recordingIdx
            
            let liveImage = titleStackView != nil ? titleStackView?.arrangedSubviews[index] : liveImageView
            liveImage?.isHidden = !(event.isLive && event.isLiveEvent())
        }
    }
}
