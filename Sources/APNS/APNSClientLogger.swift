//
//  File.swift
//  
//
//  Created by Alex Antonyuk on 04.05.2024.
//

import Foundation
import AsyncHTTPClient

public protocol APNSClientLogger {
    func logTransaction(request: HTTPClientRequest, response: HTTPClientResponse)
}

public final class APNSClientMemoryLogger: APNSClientLogger {

    public private(set) var logs: [(request: HTTPClientRequest, response: HTTPClientResponse)] = []

    public init() {

    }

    public func logTransaction(request: HTTPClientRequest, response: HTTPClientResponse) {
        logs.append((request: request, response: response))
    }

    public func pop() -> (request: HTTPClientRequest, response: HTTPClientResponse)? {
        logs.popLast()
    }
}
