//
//  Action.swift
//  
//
//  Created by Kim Nordin on 2023-08-28.
//

// Action to dispatch to the Store.
public protocol Action {}

// Represent an Action dispatcher.
public typealias Dispatch = (Action) -> Void
