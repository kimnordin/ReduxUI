//
//  Action.swift
//  
//
//  Created by Kim Nordin on 2023-08-28.
//

/**
 Dispatched action that modifies the state through the reducer.
 */
public protocol Action {}

/**
 Dispatches an action to the reducer.
 - parameter action: The action to be dispatched.
 */
public typealias Dispatch = (Action) -> Void
