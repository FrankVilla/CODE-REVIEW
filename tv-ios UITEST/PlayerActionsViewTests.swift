//
//  PlayerActionsViewTests.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 07.08.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

// swiftlint:disable file_length
// swiftlint:disable type_body_length
final class PlayerActionsViewTests: XCTestCase {

    private func waitForAsyncCycle() {
        let expectation = self.expectation(description: "Wait for async cycle")
        DispatchQueue.main.async { expectation.fulfill() }
        self.waitForExpectations(timeout: 0.1) { error in
            XCTAssertNil(error, error!.localizedDescription)
        }
    }

    // swiftlint:disable function_body_length
    func testInitialState() {
        let actionsView = PlayerActionsView.loadFromNib()
        self.waitForAsyncCycle()

        XCTAssertTrue(actionsView.viewModel.hasOnlyBaseActions)
        XCTAssertTrue(actionsView.viewModel.isAudioEnabled)
        XCTAssertFalse(actionsView.viewModel.isDescription)
        XCTAssertFalse(actionsView.viewModel.isDetail)
        XCTAssertTrue(actionsView.viewModel.isEnabled)
        XCTAssertFalse(actionsView.viewModel.isFullScreen)
        XCTAssertTrue(actionsView.viewModel.isLive)
        XCTAssertFalse(actionsView.viewModel.isMuted)
        XCTAssertFalse(actionsView.viewModel.isPlaying)
        XCTAssertFalse(actionsView.viewModel.isRecording)
        XCTAssertFalse(actionsView.viewModel.isRecordings)
        XCTAssertFalse(actionsView.viewModel.isSubtitles)
        XCTAssertFalse(actionsView.viewModel.isSubtitlesEnabled)
        XCTAssertFalse(actionsView.isTracking)

        XCTAssertFalse(actionsView.backgroundButton.isHidden)
        XCTAssertTrue(actionsView.backgroundButton.isEnabled)
        XCTAssertFalse(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertFalse(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertFalse(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertFalse(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertFalse(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertFalse(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)

        // Tests that we get the same result when setting the parameters to their same value
        actionsView.viewModel.hasOnlyBaseActions = true
        actionsView.viewModel.isAudioEnabled = true
        actionsView.viewModel.isDescription = false
        actionsView.viewModel.isDetail = false
        actionsView.viewModel.isEnabled = true
        actionsView.viewModel.isFullScreen = false
        actionsView.viewModel.isLive = true
        actionsView.viewModel.isMuted = false
        actionsView.viewModel.isPlaying = false
        actionsView.viewModel.isRecording = false
        actionsView.viewModel.isRecordings = false
        actionsView.viewModel.isSubtitles = false
        actionsView.viewModel.isSubtitlesEnabled = false
        self.waitForAsyncCycle()

        XCTAssertFalse(actionsView.backgroundButton.isHidden)
        XCTAssertTrue(actionsView.backgroundButton.isEnabled)
        XCTAssertFalse(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertFalse(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertFalse(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertFalse(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertFalse(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertFalse(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)
    }

    // swiftlint:disable function_body_length
    func testHasOnlyBaseActions() {
        let actionsView = PlayerActionsView.loadFromNib()
        self.waitForAsyncCycle()

        actionsView.viewModel.hasOnlyBaseActions = false
        actionsView.viewModel.isAudioEnabled = true
        actionsView.viewModel.isDescription = false
        actionsView.viewModel.isDetail = false
        actionsView.viewModel.isEnabled = true
        actionsView.viewModel.isFullScreen = false
        actionsView.viewModel.isLive = true
        actionsView.viewModel.isMuted = false
        actionsView.viewModel.isPlaying = false
        actionsView.viewModel.isRecording = false
        actionsView.viewModel.isRecordings = false
        actionsView.viewModel.isSubtitles = false
        actionsView.viewModel.isSubtitlesEnabled = false
        self.waitForAsyncCycle()
        XCTAssertFalse(actionsView.backgroundButton.isHidden)
        XCTAssertTrue(actionsView.backgroundButton.isEnabled)
        XCTAssertFalse(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertFalse(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertFalse(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertFalse(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertFalse(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertFalse(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertFalse(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)

        actionsView.viewModel.hasOnlyBaseActions = true
        actionsView.viewModel.isAudioEnabled = false
        actionsView.viewModel.isDescription = true
        actionsView.viewModel.isDetail = true
        actionsView.viewModel.isEnabled = false
        actionsView.viewModel.isFullScreen = true
        actionsView.viewModel.isLive = false
        actionsView.viewModel.isMuted = true
        actionsView.viewModel.isPlaying = true
        actionsView.viewModel.isRecording = true
        actionsView.viewModel.isRecordings = true
        actionsView.viewModel.isSubtitles = true
        actionsView.viewModel.isSubtitlesEnabled = true
        self.waitForAsyncCycle()
        XCTAssertTrue(actionsView.backwardButton.isHidden)
        XCTAssertFalse(actionsView.backwardButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertFalse(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertFalse(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertFalse(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertFalse(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertFalse(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertFalse(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertFalse(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertFalse(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertFalse(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertTrue(actionsView.subtitlesButton.isHidden)
        XCTAssertFalse(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertFalse(actionsView.titleLabel.isEnabled)
        XCTAssertTrue(actionsView.muteButton.isHidden)
        XCTAssertFalse(actionsView.muteButton.isEnabled)
    }

    // swiftlint:disable function_body_length
    func testIsAudioEnabled() {
        let actionsView = PlayerActionsView.loadFromNib()
        self.waitForAsyncCycle()

        actionsView.viewModel.hasOnlyBaseActions = true
        actionsView.viewModel.isAudioEnabled = false
        actionsView.viewModel.isDescription = false
        actionsView.viewModel.isDetail = false
        actionsView.viewModel.isEnabled = true
        actionsView.viewModel.isFullScreen = false
        actionsView.viewModel.isLive = true
        actionsView.viewModel.isMuted = false
        actionsView.viewModel.isPlaying = false
        actionsView.viewModel.isRecording = false
        actionsView.viewModel.isRecordings = false
        actionsView.viewModel.isSubtitles = false
        actionsView.viewModel.isSubtitlesEnabled = false
        self.waitForAsyncCycle()
        XCTAssertTrue(actionsView.backwardButton.isHidden)
        XCTAssertTrue(actionsView.backwardButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertFalse(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertTrue(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertTrue(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)

        actionsView.viewModel.hasOnlyBaseActions = false
        actionsView.viewModel.isAudioEnabled = true
        actionsView.viewModel.isDescription = true
        actionsView.viewModel.isDetail = true
        actionsView.viewModel.isEnabled = false
        actionsView.viewModel.isFullScreen = true
        actionsView.viewModel.isLive = false
        actionsView.viewModel.isMuted = true
        actionsView.viewModel.isPlaying = true
        actionsView.viewModel.isRecording = true
        actionsView.viewModel.isRecordings = true
        actionsView.viewModel.isSubtitles = true
        actionsView.viewModel.isSubtitlesEnabled = true
        self.waitForAsyncCycle()
        XCTAssertTrue(actionsView.backwardButton.isHidden)
        XCTAssertFalse(actionsView.backwardButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertFalse(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertFalse(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertFalse(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertFalse(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertFalse(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertFalse(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertFalse(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertFalse(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertFalse(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertFalse(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertFalse(actionsView.muteButton.isEnabled)
    }

    // swiftlint:disable function_body_length
    func testIsDescription() {
        let actionsView = PlayerActionsView.loadFromNib()
        self.waitForAsyncCycle()

        actionsView.viewModel.hasOnlyBaseActions = true
        actionsView.viewModel.isAudioEnabled = true
        actionsView.viewModel.isDescription = true
        actionsView.viewModel.isDetail = false
        actionsView.viewModel.isEnabled = true
        actionsView.viewModel.isFullScreen = false
        actionsView.viewModel.isLive = true
        actionsView.viewModel.isMuted = false
        actionsView.viewModel.isPlaying = false
        actionsView.viewModel.isRecording = false
        actionsView.viewModel.isRecordings = false
        actionsView.viewModel.isSubtitles = false
        actionsView.viewModel.isSubtitlesEnabled = false
        self.waitForAsyncCycle()
        XCTAssertFalse(actionsView.backgroundButton.isHidden)
        XCTAssertTrue(actionsView.backgroundButton.isEnabled)
        XCTAssertFalse(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertFalse(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertFalse(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertFalse(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertFalse(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertFalse(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)

        actionsView.viewModel.hasOnlyBaseActions = false
        actionsView.viewModel.isAudioEnabled = false
        actionsView.viewModel.isDescription = false
        actionsView.viewModel.isDetail = true
        actionsView.viewModel.isEnabled = false
        actionsView.viewModel.isFullScreen = true
        actionsView.viewModel.isLive = false
        actionsView.viewModel.isMuted = true
        actionsView.viewModel.isPlaying = true
        actionsView.viewModel.isRecording = true
        actionsView.viewModel.isRecordings = true
        actionsView.viewModel.isSubtitles = true
        actionsView.viewModel.isSubtitlesEnabled = true
        self.waitForAsyncCycle()
        XCTAssertTrue(actionsView.backwardButton.isHidden)
        XCTAssertFalse(actionsView.backwardButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertFalse(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertFalse(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertFalse(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertFalse(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertFalse(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertFalse(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertFalse(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertFalse(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertFalse(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertTrue(actionsView.subtitlesButton.isHidden)
        XCTAssertFalse(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertFalse(actionsView.titleLabel.isEnabled)
        XCTAssertTrue(actionsView.muteButton.isHidden)
        XCTAssertFalse(actionsView.muteButton.isEnabled)
    }

    // swiftlint:disable function_body_length
    func testIsDetail() {
        let actionsView = PlayerActionsView.loadFromNib()
        self.waitForAsyncCycle()

        actionsView.viewModel.hasOnlyBaseActions = true
        actionsView.viewModel.isAudioEnabled = true
        actionsView.viewModel.isDescription = false
        actionsView.viewModel.isDetail = true
        actionsView.viewModel.isEnabled = true
        actionsView.viewModel.isFullScreen = false
        actionsView.viewModel.isLive = true
        actionsView.viewModel.isMuted = false
        actionsView.viewModel.isPlaying = false
        actionsView.viewModel.isRecording = false
        actionsView.viewModel.isRecordings = false
        actionsView.viewModel.isSubtitles = false
        actionsView.viewModel.isSubtitlesEnabled = false
        self.waitForAsyncCycle()
        XCTAssertFalse(actionsView.backgroundButton.isHidden)
        XCTAssertTrue(actionsView.backgroundButton.isEnabled)
        XCTAssertFalse(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertFalse(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertFalse(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertFalse(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertFalse(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertFalse(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)

        actionsView.viewModel.hasOnlyBaseActions = false
        actionsView.viewModel.isAudioEnabled = false
        actionsView.viewModel.isDescription = true
        actionsView.viewModel.isDetail = false
        actionsView.viewModel.isEnabled = false
        actionsView.viewModel.isFullScreen = true
        actionsView.viewModel.isLive = false
        actionsView.viewModel.isMuted = true
        actionsView.viewModel.isPlaying = true
        actionsView.viewModel.isRecording = true
        actionsView.viewModel.isRecordings = true
        actionsView.viewModel.isSubtitles = true
        actionsView.viewModel.isSubtitlesEnabled = true
        self.waitForAsyncCycle()
        XCTAssertTrue(actionsView.backwardButton.isHidden)
        XCTAssertFalse(actionsView.backwardButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertFalse(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertFalse(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertFalse(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertFalse(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertFalse(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertFalse(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertFalse(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertFalse(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertFalse(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertTrue(actionsView.subtitlesButton.isHidden)
        XCTAssertFalse(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertFalse(actionsView.titleLabel.isEnabled)
        XCTAssertTrue(actionsView.muteButton.isHidden)
        XCTAssertFalse(actionsView.muteButton.isEnabled)
    }

    // swiftlint:disable function_body_length
    func testIsEnabled() {
        let actionsView = PlayerActionsView.loadFromNib()
        self.waitForAsyncCycle()

        actionsView.viewModel.hasOnlyBaseActions = true
        actionsView.viewModel.isAudioEnabled = true
        actionsView.viewModel.isDescription = false
        actionsView.viewModel.isDetail = false
        actionsView.viewModel.isEnabled = false
        actionsView.viewModel.isFullScreen = false
        actionsView.viewModel.isLive = true
        actionsView.viewModel.isMuted = false
        actionsView.viewModel.isPlaying = false
        actionsView.viewModel.isRecording = false
        actionsView.viewModel.isRecordings = false
        actionsView.viewModel.isSubtitles = false
        actionsView.viewModel.isSubtitlesEnabled = false
        self.waitForAsyncCycle()
        XCTAssertFalse(actionsView.backwardButton.isHidden)
        XCTAssertFalse(actionsView.backwardButton.isEnabled)
        XCTAssertFalse(actionsView.durationLabel.isHidden)
        XCTAssertFalse(actionsView.durationLabel.isEnabled)
        XCTAssertFalse(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertFalse(actionsView.fullScreenButton.isHidden)
        XCTAssertFalse(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertFalse(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertFalse(actionsView.playButton.isHidden)
        XCTAssertFalse(actionsView.playButton.isEnabled)
        XCTAssertFalse(actionsView.positionLabel.isHidden)
        XCTAssertFalse(actionsView.positionLabel.isEnabled)
        XCTAssertFalse(actionsView.progressSlider.isHidden)
        XCTAssertFalse(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertFalse(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertFalse(actionsView.restartButton.isEnabled)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertFalse(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertFalse(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertFalse(actionsView.muteButton.isEnabled)

        actionsView.viewModel.hasOnlyBaseActions = false
        actionsView.viewModel.isAudioEnabled = false
        actionsView.viewModel.isDescription = true
        actionsView.viewModel.isDetail = true
        actionsView.viewModel.isEnabled = true
        actionsView.viewModel.isFullScreen = true
        actionsView.viewModel.isLive = false
        actionsView.viewModel.isMuted = true
        actionsView.viewModel.isPlaying = true
        actionsView.viewModel.isRecording = true
        actionsView.viewModel.isRecordings = true
        actionsView.viewModel.isSubtitles = true
        actionsView.viewModel.isSubtitlesEnabled = true
        self.waitForAsyncCycle()
        XCTAssertTrue(actionsView.backwardButton.isHidden)
        XCTAssertTrue(actionsView.backwardButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertTrue(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertFalse(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertTrue(actionsView.subtitleLabel.isEnabled)
        XCTAssertTrue(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertTrue(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)
    }

    // swiftlint:disable function_body_length
    func testIsFullscreen() {
        let actionsView = PlayerActionsView.loadFromNib()
        self.waitForAsyncCycle()

        actionsView.viewModel.hasOnlyBaseActions = true
        actionsView.viewModel.isAudioEnabled = true
        actionsView.viewModel.isDescription = false
        actionsView.viewModel.isDetail = false
        actionsView.viewModel.isEnabled = true
        actionsView.viewModel.isFullScreen = true
        actionsView.viewModel.isLive = true
        actionsView.viewModel.isMuted = false
        actionsView.viewModel.isPlaying = false
        actionsView.viewModel.isRecording = false
        actionsView.viewModel.isRecordings = false
        actionsView.viewModel.isSubtitles = false
        actionsView.viewModel.isSubtitlesEnabled = false
        self.waitForAsyncCycle()
        XCTAssertFalse(actionsView.backgroundButton.isHidden)
        XCTAssertTrue(actionsView.backgroundButton.isEnabled)
        XCTAssertFalse(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertFalse(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertFalse(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertFalse(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertFalse(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertFalse(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)

        actionsView.viewModel.hasOnlyBaseActions = false
        actionsView.viewModel.isAudioEnabled = false
        actionsView.viewModel.isDescription = true
        actionsView.viewModel.isDetail = true
        actionsView.viewModel.isEnabled = false
        actionsView.viewModel.isFullScreen = false
        actionsView.viewModel.isLive = false
        actionsView.viewModel.isMuted = true
        actionsView.viewModel.isPlaying = true
        actionsView.viewModel.isRecording = true
        actionsView.viewModel.isRecordings = true
        actionsView.viewModel.isSubtitles = true
        actionsView.viewModel.isSubtitlesEnabled = true
        self.waitForAsyncCycle()
        XCTAssertTrue(actionsView.backwardButton.isHidden)
        XCTAssertFalse(actionsView.backwardButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertFalse(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertFalse(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertFalse(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertFalse(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertFalse(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertFalse(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertFalse(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertFalse(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertFalse(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertTrue(actionsView.subtitlesButton.isHidden)
        XCTAssertFalse(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertFalse(actionsView.titleLabel.isEnabled)
        XCTAssertTrue(actionsView.muteButton.isHidden)
        XCTAssertFalse(actionsView.muteButton.isEnabled)
    }

    // swiftlint:disable function_body_length
    func testIsLive() {
        let actionsView = PlayerActionsView.loadFromNib()
        self.waitForAsyncCycle()

        actionsView.viewModel.hasOnlyBaseActions = true
        actionsView.viewModel.isAudioEnabled = true
        actionsView.viewModel.isDescription = false
        actionsView.viewModel.isDetail = false
        actionsView.viewModel.isEnabled = true
        actionsView.viewModel.isFullScreen = false
        actionsView.viewModel.isLive = false
        actionsView.viewModel.isMuted = false
        actionsView.viewModel.isPlaying = false
        actionsView.viewModel.isRecording = false
        actionsView.viewModel.isRecordings = false
        actionsView.viewModel.isSubtitles = false
        actionsView.viewModel.isSubtitlesEnabled = false
        self.waitForAsyncCycle()
        XCTAssertFalse(actionsView.backgroundButton.isHidden)
        XCTAssertTrue(actionsView.backgroundButton.isEnabled)
        XCTAssertFalse(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertFalse(actionsView.forwardButton.isHidden)
        XCTAssertTrue(actionsView.forwardButton.isEnabled)
        XCTAssertFalse(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertTrue(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertFalse(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertFalse(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertFalse(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)

        actionsView.viewModel.hasOnlyBaseActions = false
        actionsView.viewModel.isAudioEnabled = false
        actionsView.viewModel.isDescription = true
        actionsView.viewModel.isDetail = true
        actionsView.viewModel.isEnabled = false
        actionsView.viewModel.isFullScreen = true
        actionsView.viewModel.isLive = true
        actionsView.viewModel.isMuted = true
        actionsView.viewModel.isPlaying = true
        actionsView.viewModel.isRecording = true
        actionsView.viewModel.isRecordings = true
        actionsView.viewModel.isSubtitles = true
        actionsView.viewModel.isSubtitlesEnabled = true
        self.waitForAsyncCycle()
        XCTAssertTrue(actionsView.backwardButton.isHidden)
        XCTAssertFalse(actionsView.backwardButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertFalse(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertFalse(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertFalse(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertFalse(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertFalse(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertFalse(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertFalse(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertFalse(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertFalse(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertTrue(actionsView.subtitlesButton.isHidden)
        XCTAssertFalse(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertFalse(actionsView.titleLabel.isEnabled)
        XCTAssertTrue(actionsView.muteButton.isHidden)
        XCTAssertFalse(actionsView.muteButton.isEnabled)
    }

    // swiftlint:disable function_body_length
    func testIsMuted() {
        let actionsView = PlayerActionsView.loadFromNib()
        self.waitForAsyncCycle()

        actionsView.viewModel.hasOnlyBaseActions = true
        actionsView.viewModel.isAudioEnabled = true
        actionsView.viewModel.isDescription = false
        actionsView.viewModel.isDetail = false
        actionsView.viewModel.isEnabled = true
        actionsView.viewModel.isFullScreen = false
        actionsView.viewModel.isLive = true
        actionsView.viewModel.isMuted = true
        actionsView.viewModel.isPlaying = false
        actionsView.viewModel.isRecording = false
        actionsView.viewModel.isRecordings = false
        actionsView.viewModel.isSubtitles = false
        actionsView.viewModel.isSubtitlesEnabled = false
        self.waitForAsyncCycle()
        XCTAssertFalse(actionsView.backgroundButton.isHidden)
        XCTAssertTrue(actionsView.backgroundButton.isEnabled)
        XCTAssertFalse(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertFalse(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertFalse(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertFalse(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertFalse(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertFalse(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)

        actionsView.viewModel.hasOnlyBaseActions = false
        actionsView.viewModel.isAudioEnabled = false
        actionsView.viewModel.isDescription = true
        actionsView.viewModel.isDetail = true
        actionsView.viewModel.isEnabled = false
        actionsView.viewModel.isFullScreen = true
        actionsView.viewModel.isLive = false
        actionsView.viewModel.isMuted = false
        actionsView.viewModel.isPlaying = true
        actionsView.viewModel.isRecording = true
        actionsView.viewModel.isRecordings = true
        actionsView.viewModel.isSubtitles = true
        actionsView.viewModel.isSubtitlesEnabled = true
        self.waitForAsyncCycle()
        XCTAssertTrue(actionsView.backwardButton.isHidden)
        XCTAssertFalse(actionsView.backwardButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertFalse(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertFalse(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertFalse(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertFalse(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertFalse(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertFalse(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertFalse(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertFalse(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertFalse(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertTrue(actionsView.subtitlesButton.isHidden)
        XCTAssertFalse(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertFalse(actionsView.titleLabel.isEnabled)
        XCTAssertTrue(actionsView.muteButton.isHidden)
        XCTAssertFalse(actionsView.muteButton.isEnabled)
    }

    // swiftlint:disable function_body_length
    func testIsPlaying() {
        let actionsView = PlayerActionsView.loadFromNib()
        self.waitForAsyncCycle()

        actionsView.viewModel.hasOnlyBaseActions = true
        actionsView.viewModel.isAudioEnabled = true
        actionsView.viewModel.isDescription = false
        actionsView.viewModel.isDetail = false
        actionsView.viewModel.isEnabled = true
        actionsView.viewModel.isFullScreen = false
        actionsView.viewModel.isLive = true
        actionsView.viewModel.isMuted = false
        actionsView.viewModel.isPlaying = true
        actionsView.viewModel.isRecording = false
        actionsView.viewModel.isRecordings = false
        actionsView.viewModel.isSubtitles = false
        actionsView.viewModel.isSubtitlesEnabled = false
        self.waitForAsyncCycle()
        XCTAssertFalse(actionsView.backgroundButton.isHidden)
        XCTAssertTrue(actionsView.backgroundButton.isEnabled)
        XCTAssertFalse(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertFalse(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertFalse(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertFalse(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertFalse(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertFalse(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)

        actionsView.viewModel.hasOnlyBaseActions = false
        actionsView.viewModel.isAudioEnabled = false
        actionsView.viewModel.isDescription = true
        actionsView.viewModel.isDetail = true
        actionsView.viewModel.isEnabled = false
        actionsView.viewModel.isFullScreen = true
        actionsView.viewModel.isLive = false
        actionsView.viewModel.isMuted = true
        actionsView.viewModel.isPlaying = false
        actionsView.viewModel.isRecording = true
        actionsView.viewModel.isRecordings = true
        actionsView.viewModel.isSubtitles = true
        actionsView.viewModel.isSubtitlesEnabled = true
        self.waitForAsyncCycle()
        XCTAssertTrue(actionsView.backwardButton.isHidden)
        XCTAssertFalse(actionsView.backwardButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertFalse(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertFalse(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertFalse(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertFalse(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertFalse(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertFalse(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertFalse(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertFalse(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertFalse(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertTrue(actionsView.subtitlesButton.isHidden)
        XCTAssertFalse(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertFalse(actionsView.titleLabel.isEnabled)
        XCTAssertTrue(actionsView.muteButton.isHidden)
        XCTAssertFalse(actionsView.muteButton.isEnabled)
    }

    // swiftlint:disable function_body_length
    func testIsRecording() {
        let actionsView = PlayerActionsView.loadFromNib()
        self.waitForAsyncCycle()

        actionsView.viewModel.hasOnlyBaseActions = true
        actionsView.viewModel.isAudioEnabled = true
        actionsView.viewModel.isDescription = false
        actionsView.viewModel.isDetail = false
        actionsView.viewModel.isEnabled = true
        actionsView.viewModel.isFullScreen = false
        actionsView.viewModel.isLive = true
        actionsView.viewModel.isMuted = false
        actionsView.viewModel.isPlaying = false
        actionsView.viewModel.isRecording = true
        actionsView.viewModel.isRecordings = false
        actionsView.viewModel.isSubtitles = false
        actionsView.viewModel.isSubtitlesEnabled = false
        self.waitForAsyncCycle()
        XCTAssertFalse(actionsView.backgroundButton.isHidden)
        XCTAssertTrue(actionsView.backgroundButton.isEnabled)
        XCTAssertFalse(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertFalse(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertFalse(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertFalse(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertFalse(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertFalse(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)

        actionsView.viewModel.hasOnlyBaseActions = false
        actionsView.viewModel.isAudioEnabled = false
        actionsView.viewModel.isDescription = true
        actionsView.viewModel.isDetail = true
        actionsView.viewModel.isEnabled = false
        actionsView.viewModel.isFullScreen = true
        actionsView.viewModel.isLive = false
        actionsView.viewModel.isMuted = true
        actionsView.viewModel.isPlaying = true
        actionsView.viewModel.isRecording = false
        actionsView.viewModel.isRecordings = true
        actionsView.viewModel.isSubtitles = true
        actionsView.viewModel.isSubtitlesEnabled = true
        self.waitForAsyncCycle()
        XCTAssertTrue(actionsView.backwardButton.isHidden)
        XCTAssertFalse(actionsView.backwardButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertFalse(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertFalse(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertFalse(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertFalse(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertFalse(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertFalse(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertFalse(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertFalse(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertFalse(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertTrue(actionsView.subtitlesButton.isHidden)
        XCTAssertFalse(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertFalse(actionsView.titleLabel.isEnabled)
        XCTAssertTrue(actionsView.muteButton.isHidden)
        XCTAssertFalse(actionsView.muteButton.isEnabled)
    }

    // swiftlint:disable function_body_length
    func testIsRecordings() {
        let actionsView = PlayerActionsView.loadFromNib()
        self.waitForAsyncCycle()

        actionsView.viewModel.hasOnlyBaseActions = true
        actionsView.viewModel.isAudioEnabled = true
        actionsView.viewModel.isDescription = false
        actionsView.viewModel.isDetail = false
        actionsView.viewModel.isEnabled = true
        actionsView.viewModel.isFullScreen = false
        actionsView.viewModel.isLive = true
        actionsView.viewModel.isMuted = false
        actionsView.viewModel.isPlaying = true
        actionsView.viewModel.isRecording = true
        actionsView.viewModel.isRecordings = true
        actionsView.viewModel.isSubtitles = false
        actionsView.viewModel.isSubtitlesEnabled = false
        self.waitForAsyncCycle()
        XCTAssertFalse(actionsView.backgroundButton.isHidden)
        XCTAssertTrue(actionsView.backgroundButton.isEnabled)
        XCTAssertFalse(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertFalse(actionsView.forwardButton.isHidden)
        XCTAssertTrue(actionsView.forwardButton.isEnabled)
        XCTAssertFalse(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertFalse(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertFalse(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertFalse(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)

        actionsView.viewModel.hasOnlyBaseActions = false
        actionsView.viewModel.isAudioEnabled = false
        actionsView.viewModel.isDescription = true
        actionsView.viewModel.isDetail = true
        actionsView.viewModel.isEnabled = false
        actionsView.viewModel.isFullScreen = true
        actionsView.viewModel.isLive = false
        actionsView.viewModel.isMuted = true
        actionsView.viewModel.isPlaying = false
        actionsView.viewModel.isRecording = false
        actionsView.viewModel.isRecordings = false
        actionsView.viewModel.isSubtitles = true
        actionsView.viewModel.isSubtitlesEnabled = true
        self.waitForAsyncCycle()
        XCTAssertTrue(actionsView.backwardButton.isHidden)
        XCTAssertFalse(actionsView.backwardButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertFalse(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertFalse(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertFalse(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertFalse(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertFalse(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertFalse(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertFalse(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertFalse(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertFalse(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertTrue(actionsView.subtitlesButton.isHidden)
        XCTAssertFalse(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertFalse(actionsView.titleLabel.isEnabled)
        XCTAssertTrue(actionsView.muteButton.isHidden)
        XCTAssertFalse(actionsView.muteButton.isEnabled)
    }

    // swiftlint:disable function_body_length
    func testIsSubtitles() {
        let actionsView = PlayerActionsView.loadFromNib()
        self.waitForAsyncCycle()

        actionsView.viewModel.hasOnlyBaseActions = true
        actionsView.viewModel.isAudioEnabled = true
        actionsView.viewModel.isDescription = false
        actionsView.viewModel.isDetail = false
        actionsView.viewModel.isEnabled = true
        actionsView.viewModel.isFullScreen = false
        actionsView.viewModel.isLive = true
        actionsView.viewModel.isMuted = false
        actionsView.viewModel.isPlaying = true
        actionsView.viewModel.isRecording = false
        actionsView.viewModel.isRecordings = true
        actionsView.viewModel.isSubtitles = true
        actionsView.viewModel.isSubtitlesEnabled = false
        self.waitForAsyncCycle()
        XCTAssertFalse(actionsView.backgroundButton.isHidden)
        XCTAssertTrue(actionsView.backgroundButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertTrue(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)

        actionsView.viewModel.hasOnlyBaseActions = false
        actionsView.viewModel.isAudioEnabled = false
        actionsView.viewModel.isDescription = true
        actionsView.viewModel.isDetail = true
        actionsView.viewModel.isEnabled = false
        actionsView.viewModel.isFullScreen = true
        actionsView.viewModel.isLive = false
        actionsView.viewModel.isMuted = true
        actionsView.viewModel.isPlaying = false
        actionsView.viewModel.isRecording = true
        actionsView.viewModel.isRecordings = false
        actionsView.viewModel.isSubtitles = false
        actionsView.viewModel.isSubtitlesEnabled = true
        self.waitForAsyncCycle()
        XCTAssertTrue(actionsView.backwardButton.isHidden)
        XCTAssertFalse(actionsView.backwardButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertFalse(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertFalse(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertFalse(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertFalse(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertFalse(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertFalse(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertFalse(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertFalse(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertFalse(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertTrue(actionsView.subtitlesButton.isHidden)
        XCTAssertFalse(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertFalse(actionsView.titleLabel.isEnabled)
        XCTAssertTrue(actionsView.muteButton.isHidden)
        XCTAssertFalse(actionsView.muteButton.isEnabled)
    }

    // swiftlint:disable function_body_length
    func testIsSubtitlesEnabled() {
        let actionsView = PlayerActionsView.loadFromNib()
        self.waitForAsyncCycle()

        actionsView.viewModel.hasOnlyBaseActions = true
        actionsView.viewModel.isAudioEnabled = true
        actionsView.viewModel.isDescription = false
        actionsView.viewModel.isDetail = false
        actionsView.viewModel.isEnabled = true
        actionsView.viewModel.isFullScreen = false
        actionsView.viewModel.isLive = true
        actionsView.viewModel.isMuted = false
        actionsView.viewModel.isPlaying = true
        actionsView.viewModel.isRecording = false
        actionsView.viewModel.isRecordings = false
        actionsView.viewModel.isSubtitles = true
        actionsView.viewModel.isSubtitlesEnabled = true
        self.waitForAsyncCycle()
        XCTAssertFalse(actionsView.backgroundButton.isHidden)
        XCTAssertTrue(actionsView.backgroundButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertTrue(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertTrue(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertTrue(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertTrue(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertTrue(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertTrue(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertTrue(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertTrue(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertTrue(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertTrue(actionsView.subtitleLabel.isEnabled)
        XCTAssertFalse(actionsView.subtitlesButton.isHidden)
        XCTAssertTrue(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertTrue(actionsView.titleLabel.isEnabled)
        XCTAssertFalse(actionsView.muteButton.isHidden)
        XCTAssertTrue(actionsView.muteButton.isEnabled)

        actionsView.viewModel.hasOnlyBaseActions = false
        actionsView.viewModel.isAudioEnabled = false
        actionsView.viewModel.isDescription = true
        actionsView.viewModel.isDetail = true
        actionsView.viewModel.isEnabled = false
        actionsView.viewModel.isFullScreen = true
        actionsView.viewModel.isLive = false
        actionsView.viewModel.isMuted = true
        actionsView.viewModel.isPlaying = false
        actionsView.viewModel.isRecording = true
        actionsView.viewModel.isRecordings = true
        actionsView.viewModel.isSubtitles = false
        actionsView.viewModel.isSubtitlesEnabled = false
        self.waitForAsyncCycle()
        XCTAssertTrue(actionsView.backwardButton.isHidden)
        XCTAssertFalse(actionsView.backwardButton.isEnabled)
        XCTAssertTrue(actionsView.durationLabel.isHidden)
        XCTAssertFalse(actionsView.durationLabel.isEnabled)
        XCTAssertTrue(actionsView.forwardButton.isHidden)
        XCTAssertFalse(actionsView.forwardButton.isEnabled)
        XCTAssertTrue(actionsView.fullScreenButton.isHidden)
        XCTAssertFalse(actionsView.fullScreenButton.isEnabled)
        XCTAssertFalse(actionsView.infoButton.isHidden)
        XCTAssertFalse(actionsView.infoButton.isEnabled)
        XCTAssertTrue(actionsView.liveButton.isHidden)
        XCTAssertFalse(actionsView.liveButton.isEnabled)
        XCTAssertFalse(actionsView.muteIcon.isHidden)
        XCTAssertTrue(actionsView.playButton.isHidden)
        XCTAssertFalse(actionsView.playButton.isEnabled)
        XCTAssertTrue(actionsView.positionLabel.isHidden)
        XCTAssertFalse(actionsView.positionLabel.isEnabled)
        XCTAssertTrue(actionsView.progressSlider.isHidden)
        XCTAssertFalse(actionsView.progressSlider.isEnabled)
        XCTAssertTrue(actionsView.recordingButton.isHidden)
        XCTAssertFalse(actionsView.recordingButton.isEnabled)
        XCTAssertTrue(actionsView.restartButton.isHidden)
        XCTAssertFalse(actionsView.restartButton.isEnabled)
        XCTAssertTrue(actionsView.secondaryProgressSlider.isHidden)
        XCTAssertFalse(actionsView.secondaryProgressSlider.isEnabled)
        XCTAssertTrue(actionsView.subtitleLabel.isHidden)
        XCTAssertFalse(actionsView.subtitleLabel.isEnabled)
        XCTAssertTrue(actionsView.subtitlesButton.isHidden)
        XCTAssertFalse(actionsView.subtitlesButton.isEnabled)
        XCTAssertTrue(actionsView.titleLabel.isHidden)
        XCTAssertFalse(actionsView.titleLabel.isEnabled)
        XCTAssertTrue(actionsView.muteButton.isHidden)
        XCTAssertFalse(actionsView.muteButton.isEnabled)
    }

    func testActions() {
        let actionsView = PlayerActionsView.loadFromNib()
        let delegate = MockPlayerActionsViewDelegate()
        actionsView.delegate = delegate
        XCTAssertEqual(delegate.actions, [])

        actionsView.backwardButton.sendActions(for: .touchUpInside)
        actionsView.forwardButton.sendActions(for: .touchUpInside)
        actionsView.fullScreenButton.sendActions(for: .touchUpInside)
        actionsView.infoButton.sendActions(for: .touchUpInside)
        actionsView.liveButton.sendActions(for: .touchUpInside)
        actionsView.playButton.sendActions(for: .touchUpInside)
        actionsView.recordingButton.sendActions(for: .touchUpInside)
        actionsView.restartButton.sendActions(for: .touchUpInside)
        actionsView.subtitlesButton.sendActions(for: .touchUpInside)
        actionsView.muteButton.sendActions(for: .touchUpInside)
        actionsView.backgroundButton.sendActions(for: .touchUpInside)

        actionsView.progressSlider.sendActions(for: .touchDown)
        actionsView.progressSlider.sendActions(for: .valueChanged)
        actionsView.progressSlider.sendActions(for: .touchUpInside)

        XCTAssertEqual(
            delegate.actions,
            [
                .skipBackward,
                .skipForward,
                .togglePresentationMode,
                .showInfo,
                .seekLive,
                .togglePlayPause,
                .recordShow,
                .restart,
                .showAudioAndSubtitlesMenu,
                .toggleMute,
                .hide,
                .userDidBeginSeekingProgress,
                .userDidSeekProgress,
                .userDidEndSeekingProgress
            ]
        )
    }
}

private class MockPlayerActionsViewDelegate: PlayerActionsViewDelegate {
    enum Actions: String {
        case togglePlayPause
        case toggleMute
        case togglePresentationMode
        case showAudioAndSubtitlesMenu
        case showInfo
        case hide
        case recordShow
        case restart
        case skipBackward
        case skipForward
        case seekLive

        // Slider
        case userDidBeginSeekingProgress
        case userDidEndSeekingProgress
        case userDidSeekProgress
    }

    private(set) var actions = [Actions]()

    func playerActionsViewDidRequestToTogglePlayPause(_ view: PlayerActionsView) {
        self.actions.append(.togglePlayPause)
    }

    func playerActionsViewDidRequestToToggleMute(_ view: PlayerActionsView) {
        self.actions.append(.toggleMute)
    }

    func playerActionsViewDidRequestToTogglePresentationMode(_ view: PlayerActionsView) {
        self.actions.append(.togglePresentationMode)
    }

    func playerActionsViewDidRequestToShowAudioAndSubtitlesMenu(_ view: PlayerActionsView) {
        self.actions.append(.showAudioAndSubtitlesMenu)
    }

    func playerActionsViewDidRequestToShowInfo(_ view: PlayerActionsView) {
        self.actions.append(.showInfo)
    }

    func playerActionsViewDidRequestToBeHidden(_ view: PlayerActionsView) {
        self.actions.append(.hide)
    }

    func playerActionsViewDidRequestToRestart(_ view: PlayerActionsView) {
        self.actions.append(.restart)
    }

    func playerActionsViewDidRequestToSkipBackward(_ view: PlayerActionsView) {
        self.actions.append(.skipBackward)
    }

    func playerActionsViewDidRequestToSkipForward(_ view: PlayerActionsView) {
        self.actions.append(.skipForward)
    }

    func playerActionsViewDidRequestToSeekLive(_ view: PlayerActionsView) {
        self.actions.append(.seekLive)
    }

    func playerActionsViewDidRequestToRecordShow(_ view: PlayerActionsView) {
        self.actions.append(.recordShow)
    }

    func playerActionsView(_ view: PlayerActionsView, userDidBeginSeekingProgress progress: Float) {
        self.actions.append(.userDidBeginSeekingProgress)
    }

    func playerActionsView(_ view: PlayerActionsView, userDidSeekProgress progress: Float) {
        self.actions.append(.userDidSeekProgress)
    }

    func playerActionsView(_ view: PlayerActionsView, userDidEndSeekingProgress progress: Float) {
        self.actions.append(.userDidEndSeekingProgress)
    }
}
