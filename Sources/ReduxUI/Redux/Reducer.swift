//
//  Reducer.swift
//  ReduxUI
//
//  Created by Kim Nordin on 2023-08-28.
//

/**
 Receives an action and the current state, returning the modified state.
 - parameter action: An action causing the state to change.
 - parameter state: The current state.
 - returns: The new state after the action has been applied.
 */
public typealias Reducer<State> = (Action, State) -> State
