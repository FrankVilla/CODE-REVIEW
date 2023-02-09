//
//  NetworkMonitor.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 25/02/2022.
//

import Foundation
import Network


final class NetworkMonitor{
    static let shared = NetworkMonitor()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnetcted: Bool = false
    public private (set) var connectionType: ConnectionType = .unknow
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknow
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnetcted = path.status != .unsatisfied
            self?.getConnectionType(path)
        }
    }
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        }
        else  if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        }
        else  if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        }
        else {
            connectionType = .unknow
        }
    }
}
