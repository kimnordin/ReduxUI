//
//  Action.swift
//  
//
//  Created by Kim Nordin on 2023-08-28.
//

// Action to dispatch to the Store.
protocol Action {}

// Represent an Action dispatcher.
typealias Dispatch = (Action) -> Void
