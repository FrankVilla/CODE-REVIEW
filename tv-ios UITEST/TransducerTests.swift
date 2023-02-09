//
//  TransducerTests.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 2020-07-31.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

final class TransducerTests: XCTestCase {
    func test() {
        var coinsSpent = 0
        var result: GateState = .locked

        var enteredStates = [GateState]()
        var exitedStates = [GateState]()

        let transducer = Transducer<GateState, GateTrigger>(state: .locked)

        transducer.addTransition(withOrigin: .locked, trigger: .coin, destination: .unlocked) {
            coinsSpent += 1
            result = .unlocked
        }
        transducer.addTransition(withOrigin: .unlocked, trigger: .push, destination: .locked) {
            result = .locked
        }

        transducer.addEntry(for: .locked, withAction: {
            enteredStates.append(.locked)
        })

        transducer.addExit(for: .locked, withAction: {
            exitedStates.append(.locked)
        })

        transducer.addEntry(for: .unlocked, withAction: {
            enteredStates.append(.unlocked)
        })

        transducer.addExit(for: .unlocked, withAction: {
            exitedStates.append(.unlocked)
        })

        transducer.start()

        // it is initialy locked
        XCTAssertEqual(result, .locked)
        XCTAssertEqual(enteredStates, [.locked])
        XCTAssertEqual(exitedStates, [])

        // When locked after inserting a coin increases coins spent and unlocks
        transducer.fire(.coin)
        XCTAssertEqual(coinsSpent, 1)
        XCTAssertEqual(result, .unlocked)
        XCTAssertEqual(enteredStates, [.locked, .unlocked])
        XCTAssertEqual(exitedStates, [.locked])

        // After inserting another coin, it does not increase coins spent and stays unlocked
        transducer.fire(.coin)
        XCTAssertEqual(coinsSpent, 1)
        XCTAssertEqual(result, .unlocked)
        XCTAssertEqual(enteredStates, [.locked, .unlocked])
        XCTAssertEqual(exitedStates, [.locked])

        // After push it locks
        transducer.fire(.push)
        XCTAssertEqual(result, .locked)
        XCTAssertEqual(enteredStates, [.locked, .unlocked, .locked])
        XCTAssertEqual(exitedStates, [.locked, .unlocked])
    }
}

private enum GateState: TransducerState {
    case locked
    case unlocked
}

private enum GateTrigger: TransducerTrigger {
    typealias State = GateState
    case push
    case coin
}
