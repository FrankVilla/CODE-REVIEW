//
//  MockPlayer.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 2020-08-02.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import UIKit
@testable import tv_ios

struct MockPlayer: Player {
    var buffer: PlayerBuffer?
    weak var delegate: PlayerDelegate?
    var httpHeaders: [String: String] = [:]
    var isLive: Bool = false
    var isLiveStreaming: Bool = false
    var isLiveSeekable: Bool = false
    var isPaused: Bool = false
    var isPlaying: Bool = false
    var isRecordings: Bool = false
    var version: String?
    var seekTime: Int = 0
    var state: PlayerState?
    var url: String?
    var duration: Int = 0
    var minPosition: Int = 0
    var maxPosition: Int = 0
    var position: Int = 0
    var utcPosition: Int = 0

    func changeLanguage(_ language: String) {}
    func changeSubtitle(_ subtitle: String) {}
    func enableSubtitles(_ value: Bool) {}
    func fetchLanguages() -> [String] { [] }
    func fetchSubtitles() -> [String] { [] }
    func mute() {}
    func notifyViewSizeChanged() {}
    func pause() {}
    func play() {}
    func play(_ seekTime: Int) {}
    func resetBufferRange() {}
    func restart() {}
    func seek(by seekTime: Int) {}
    func seekBackwards(_ seekTime: Int) {}
    func seekLive() {}
    func seekTo(progress: Float) {}
    func setBufferRange(_ date: Date) {}
    func setHttpHeaders() {}
    func stop() {}
    func unmute() {}
    func updateBufferOffset() {}
}
