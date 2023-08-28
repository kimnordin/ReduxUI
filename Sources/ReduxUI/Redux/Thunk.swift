//
//  Thunk.swift
//  
//
//  Created by Kim Nordin on 2023-08-28.
//

// A Thunk to perform asynchronous or chained operations.

@available(iOS 13.0, *)
@available(macOS 10.15, *)
protocol ThunkAction: Action {
    associatedtype State: StateType
    func execute(with store: Store<State>)
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
struct AnyThunkAction<State: StateType>: ThunkAction {
    private let _execute: (Store<State>) -> Void
    
    init<T: ThunkAction>(_ thunkAction: T) where T.State == State {
        _execute = thunkAction.execute
    }
    
    func execute(with store: Store<State>) {
        _execute(store)
    }
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
struct Thunk<AssociatedState: StateType>: ThunkAction {
    typealias State = AssociatedState
    
    let thunk: (@escaping Dispatch, @escaping () -> State?) -> Void

    init(_ thunk: @escaping (@escaping Dispatch, @escaping () -> State?) -> Void) {
        self.thunk = thunk
    }

    func execute(with store: Store<State>) {
        thunk(store.dispatch, { store.state })
    }
}
