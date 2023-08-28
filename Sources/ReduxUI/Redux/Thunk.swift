//
//  Thunk.swift
//  
//
//  Created by Kim Nordin on 2023-08-28.
//

// A Thunk to perform asynchronous or chained operations.
protocol ThunkAction: Action where StateType: Equatable {
    associatedtype StateType
    func execute(with store: Store<StateType>)
}

struct Thunk<State: StateType>: ThunkAction {
    let thunk: (@escaping Dispatch, @escaping () -> State?) -> Void

    init(_ thunk: @escaping (@escaping Dispatch, @escaping () -> State?) -> Void) {
        self.thunk = thunk
    }

    func execute(dispatch: @escaping Dispatch, getState: @escaping () -> State?) {
        thunk(dispatch, getState)
    }
}
