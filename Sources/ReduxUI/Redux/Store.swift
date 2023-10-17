//
//  Store.swift
//  
//
//  Created by Kim Nordin on 2023-08-28.
//

import SwiftUI

// Represents the main application Store.

public protocol StoreSubscriber: AnyObject {
    func newState(state: any StateType)
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
public class Store<State: StateType>: ObservableObject {
    @Published public private(set) var state: State
    private let reducer: Reducer<State>
    private var dispatchFunction: Dispatch!
    public private(set) var subscribers: [WeakSubscriber] = []
    
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
    
    public func subscribe(_ subscriber: StoreSubscriber) {
        if subscribers.contains(where: { $0.reference === subscriber }) {
            return
        }

        subscribers.append(WeakSubscriber(reference: subscriber))
        subscriber.newState(state: state)
    }

    public func unsubscribe(_ subscriber: StoreSubscriber) {
        subscribers.removeAll { $0.reference === subscriber }
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
        state = reducer(state, action)
        notifySubscribers()
    }

    private func notifySubscribers() {
        for weakSubscriber in subscribers {
            guard let subscriber = weakSubscriber.reference else {
                // Remove subscribers if it's nil
                subscribers.removeAll { $0.reference == nil }
                continue
            }
            subscriber.newState(state: state)
        }
    }
}

// Weak Subscriber wrapper
public class WeakSubscriber {
    weak var reference: StoreSubscriber?

    init(reference: StoreSubscriber) {
        self.reference = reference
    }
}
