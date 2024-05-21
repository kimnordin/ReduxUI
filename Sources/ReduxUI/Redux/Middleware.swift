//
//  Middleware.swift
//  ReduxUI
//
//  Created by Kim Nordin on 2023-08-28.
//

/**
 Wraps the dispatch function, allowing for processing and modifications of actions before they reach the redicer.
 - parameter dispatch: The original dispatch function that sends actions  to the reducer.
 - parameter state: A function that returns the current state or nil if there is no state available.
 - returns: A function that takes the original dispatch function and returns a new dispatch function that encapsulates any added middleware logic.
 */
public typealias Middleware<State> = (_ dispatch: @escaping Dispatch, _ state: @escaping () -> State?) -> (@escaping Dispatch) -> Dispatch
