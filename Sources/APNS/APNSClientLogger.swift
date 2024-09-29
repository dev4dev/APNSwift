//
//  File.swift
//  
//
//  Created by Alex Antonyuk on 04.05.2024.
//

import AsyncHTTPClient
import Foundation
import os

public protocol APNSClientLogger: Sendable {
    func logTransaction(request: HTTPClientRequest, response: HTTPClientResponse)
}

public final class APNSClientMemoryLogger: APNSClientLogger {

    public let logs: OSAllocatedUnfairLock<[(request: HTTPClientRequest, response: HTTPClientResponse)]> = .init(initialState: [])

    public init() {

    }

    public func logTransaction(request: HTTPClientRequest, response: HTTPClientResponse) {
        logs.withLock {
            $0.append((request: request, response: response))
        }
    }

    public func pop() -> (request: HTTPClientRequest, response: HTTPClientResponse)? {
        logs.withLock {
            $0.popLast()
        }
    }
}
