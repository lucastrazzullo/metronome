//
//  PublisherExtensions.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 30/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Combine

public protocol OptionalType {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}


extension Optional: OptionalType {
    public var optional: Wrapped? { self }
}


extension Publisher where Output: OptionalType {

    public func ignoreNil() -> AnyPublisher<Output.Wrapped, Failure> {
        flatMap { output -> AnyPublisher<Output.Wrapped, Failure> in
            if let output = output.optional {
                return Just(output).setFailureType(to: Failure.self).eraseToAnyPublisher()
            } else {
                return Empty<Output.Wrapped, Failure>(completeImmediately: false).eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}
