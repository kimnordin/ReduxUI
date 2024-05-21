//
//  Store.swift
//  ReduxUI
//
//  Created by Kim Nordin on 2023-08-28.
//

import SwiftUI

/**
 Main store of the application which holds the entire state.
 
 The store manages the lifecycle of state changes, handles dispatching actions to reducers, and notifies subscribers about state updates.
 - parameter state: The initial state of the application.
 - parameter reducer: A function responsible for handling state changes in response to actions.
 - parameter middlewares: An array of middleware functions that can intercept, modify, or asynchronously handle actions before they reach the reducer.
 */
@available(iOS 13.0, *)
@available(macOS 10.15, *)
public class Store<State: StateType>: ObservableObject {
    @Published public private(set) var state: State
    private let reducer: Reducer<State>
    private var dispatchFunction: Dispatch!
    
    public init(state: State, reducer: @escaping Reducer<State>, middlewares: [Middleware<State>] = []) {
        self.state = state
        self.reducer = reducer
        
        self.dispatchFunction = middlewares
            .reduce({ [unowned self] action in
                self._dispatch(action: action)
            }, { dispatchFunction, middleware in
                let dispatch: (Action) -> Void = { [weak self] in self?.dispatch($0) }
                let getState = { [weak self] in self?.state }
                return middleware(dispatch, getState)(dispatchFunction)
            })
    }
    
    // To Middleware
    public func dispatch(_ action: Action) {
        if let thunkAction = action as? Thunk<State> {
            thunkAction.execute(with: self)
        } else {
            dispatchFunction(action)
        }
    }
    
    // To Reducer
    public func _dispatch(action: Action) {
        state = reducer(action, state)
    }
}
