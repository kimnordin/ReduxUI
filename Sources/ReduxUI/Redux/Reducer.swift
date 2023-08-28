//
//  Reducer.swift
//  
//
//  Created by Kim Nordin on 2023-08-28.
//

// Represents a Reducer function to mutate the state.
typealias Reducer<State> = (State, Action) -> State
