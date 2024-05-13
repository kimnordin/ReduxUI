//
//  Reducer.swift
//  
//
//  Created by Kim Nordin on 2023-08-28.
//

/**
 Receives an action and the current state, returning the modified state.
 - parameters state: The current state.
 - parameters action: An action causing the state to change.
 - returns: The new state after the action has been applied.
 */
public typealias Reducer<State> = (State, Action) -> State
