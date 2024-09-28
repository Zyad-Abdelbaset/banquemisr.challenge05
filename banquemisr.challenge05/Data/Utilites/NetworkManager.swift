//
//  NetworkManager.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation
import Network

protocol ConnectionProtocol {
    func checkConnectivity(compilation: @escaping(Bool)->())
}

class Connection: ConnectionProtocol {
    static let shared = Connection()
    private init() {}
    
    func checkConnectivity(compilation: @escaping(Bool)->()) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            let status = path.status == .satisfied
            DispatchQueue.main.async {
                compilation(status)
            }
            monitor.cancel()
        }
        monitor.start(queue: .main)
    }
}


