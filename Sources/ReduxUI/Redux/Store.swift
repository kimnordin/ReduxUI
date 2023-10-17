//
//  Store.swift
//  
//
//  Created by Kim Nordin on 2023-08-28.
//

import SwiftUI

// Represents the main application Store.

protocol StoreSubscriber {
    func newState(_ state: any StateType)
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
class Store<State: StateType>: ObservableObject {
    @Published private(set) var state: State
    private let reducer: Reducer<State>
    private var dispatchFunction: Dispatch!
    
    init(state: State, reducer: @escaping Reducer<State>, middlewares: [Middleware<State>] = []) {
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
    func dispatch(_ action: Action) {
        if let thunkAction = action as? Thunk<State> {
            thunkAction.execute(with: self)
        } else {
            dispatchFunction(action)
        }
    }
    
    // To Reducer
    private func _dispatch(action: Action) {
        state = reducer(state, action)
    }
}
