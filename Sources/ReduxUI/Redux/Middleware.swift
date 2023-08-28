//
//  Middleware.swift
//  
//
//  Created by Kim Nordin on 2023-08-28.
//

// Represents a Middleware for pre- or post-processing actions.
public typealias Middleware<State> = (@escaping Dispatch, @escaping () -> State?) -> (@escaping Dispatch) -> Dispatch
