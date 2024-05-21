//
//  StoreSubscriber.swift
//  ReduxUI
//
//  Created by Kim Nordin on 2024-05-21.
//

/**
 Defines a subscriber of state updates.
 */
public protocol StoreSubscriber {
    associatedtype State: StateType
    
    /**
     Called whenever the store's state changes.
     - parameter state: The new state from the store.
     */
    func newState(_ state: State)
}
