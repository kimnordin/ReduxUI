//
//  Thunk.swift
//  
//
//  Created by Kim Nordin on 2023-08-28.
//

// A Thunk to perform asynchronous or chained operations.
@available(iOS 13.0, *)
@available(macOS 10.15, *)
public struct Thunk<AssociatedState: StateType>: Action {
    public typealias State = AssociatedState
    
    let thunk: (@escaping Dispatch, @escaping () -> State?) -> Void

    public init(_ thunk: @escaping (@escaping Dispatch, @escaping () -> State?) -> Void) {
        self.thunk = thunk
    }

    func execute(with store: Store<State>) {
        thunk(store.dispatch, { store.state })
    }
}

