//
//  Store.swift
//  
//
//  Created by Kim Nordin on 2023-08-28.
//

import SwiftUI

// Represents the main application Store.

protocol StoreProtocol {
    associatedtype StoreState: StateType
    var state: StoreState { get }
    func dispatch(_ action: Action)
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
class Store<State: StateType>: StoreProtocol, ObservableObject {
    @Published private(set) var state: State
    private let reducer: Reducer<State>
    private var middlewares: [Middleware<State>]
    private lazy var dispatchFunction: Dispatch = createDispatchFunction()

    init(state: State, reducer: @escaping Reducer<State>, middlewares: [Middleware<State>] = []) {
        self.state = state
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    private func createDispatchFunction() -> Dispatch {
        return middlewares.reversed().reduce({ [unowned self] in self.applyReducer(action: $0) }) { (dispatchFunction, middleware) in
            let dispatch: (Action) -> Void = { [unowned self] in self.dispatch($0) }
            let getState = { [unowned self] in self.state }
            return middleware(dispatch, getState)(dispatchFunction)
        }
    }
    
    func dispatch(_ action: Action) {
        if let thunkAction = action as? AnyThunkAction<State> {
            thunkAction.execute(with: self)
        } else {
            dispatchFunction(action)
        }
    }
    
    private func applyReducer(action: Action) {
        state = reducer(state, action)
    }
}
