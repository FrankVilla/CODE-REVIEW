//
//  TVGuideModelTests.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 03.08.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

final class TVGuideViewModelTests: XCTestCase {

    // The filter compares the lowercase and without spaces versions of the channel names.
    // So " SFr   1 " is converted to "sfr1" for searching purposes
    func testFilterChannels() {
        let channel1 = Channel.mock(name: "SFR 1")
        let channel2 = Channel.mock(name: "SFR 2")
        let channel3 = Channel.mock(name: "DMAX HD")

        let viewModel = TVGuideViewModel.mock(with: [channel1, channel2, channel3])

        XCTAssertEqual(viewModel.filteredChannels.map { $0.name }, [channel1, channel2, channel3].map { $0.name })

        viewModel.query = ""
        XCTAssertEqual(viewModel.filteredChannels.map { $0.name }, [channel1, channel2, channel3].map { $0.name })

        viewModel.query = "   "
        XCTAssertEqual(viewModel.filteredChannels.map { $0.name }, [channel1, channel2, channel3].map { $0.name })

        viewModel.query = "SFR"
        viewModel.filterChannels()
        XCTAssertEqual(viewModel.filteredChannels.map { $0.name }, [channel1, channel2].map { $0.name })

        viewModel.query = "sfr    "
        viewModel.filterChannels()
        XCTAssertEqual(viewModel.filteredChannels.map { $0.name }, [channel1, channel2].map { $0.name })

        viewModel.query = "    DMAX"
        viewModel.filterChannels()
        XCTAssertEqual(viewModel.filteredChannels.map { $0.name }, [channel3].map { $0.name })

        viewModel.query = "SFR 1"
        viewModel.filterChannels()
        XCTAssertEqual(viewModel.filteredChannels.map { $0.name }, [channel1].map { $0.name })

        viewModel.query = "Sfr        1"
        viewModel.filterChannels()
        XCTAssertEqual(viewModel.filteredChannels.map { $0.name }, [channel1].map { $0.name })
    }
    
    func testFindIndex() {
        let channel1 = Channel.mock(id: "1", name: "SFR 1")
        let channel2 = Channel.mock(id: "2", name: "SFR 2")
        let channel3 = Channel.mock(id: "3", name: "DMAX HD")

        let viewModel = TVGuideViewModel.mock(with: [channel1, channel2, channel3])
        
        XCTAssertEqual(viewModel.findIndex(for: channel1), 0)
        XCTAssertEqual(viewModel.findIndex(for: channel2), 1)
        XCTAssertEqual(viewModel.findIndex(for: channel3), 2)
    }
    
    func testChannel() {
        let channel1 = Channel.mock(id: "1", name: "SFR 1")
        let channel2 = Channel.mock(id: "2", name: "SFR 2")
        let channel3 = Channel.mock(id: "3", name: "DMAX HD")

        let viewModel = TVGuideViewModel.mock(with: [channel1, channel2, channel3])
        
        XCTAssertEqual(viewModel.channel(id: channel1.id)?.name ?? "", channel1.name)
        XCTAssertEqual(viewModel.channel(id: channel2.id)?.name ?? "", channel2.name)
        XCTAssertEqual(viewModel.channel(id: channel3.id)?.name ?? "", channel3.name)
    }
    
    func testSetEvents() {
        let channel1 = Channel.mock(id: "1", name: "SFR 1")
        let channel2 = Channel.mock(id: "2", name: "SFR 2")
        let channel3 = Channel.mock(id: "3", name: "DMAX HD")

        let viewModel = TVGuideViewModel.mock(with: [channel1, channel2, channel3])
        
        let event1 = Event.mock(id: "1", title: "Event 1")
        let event2 = Event.mock(id: "2", title: "Event 2")
        
        viewModel.setEvents([event1, event2], forChannelId: channel1.id)
        XCTAssertEqual(viewModel.findEvent(with: event1.id)?.title ?? "",  event1.title)
    }
}
