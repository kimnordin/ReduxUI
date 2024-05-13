//
//  TestUtilities.swift
//
//
//  Created by Kim Nordin on 2024-05-14.
//

import XCTest
@testable import ReduxUI

internal struct AppState: StateType {
    var value: Int
}

internal struct IncrementAction: Action {
    let add: Int
}

internal struct DecrementAction: Action {
    let subtract: Int
}

internal func appReducer(_ action: Action, _ state: AppState) -> AppState {
    var state = state
    switch action {
    case let action as IncrementAction:
        state.value += action.add
    case let action as DecrementAction:
        state.value -= action.subtract
    default:
        break
    }
    return state
}

internal func appMiddleware(_ dispatch: @escaping Dispatch, _ getState: @escaping () -> AppState?) -> (@escaping Dispatch) -> Dispatch {
    return { next in
        return { action in
            if let incrementAction = action as? IncrementAction {
                let modifiedAction = IncrementAction(add: incrementAction.add + 5)
                return next(modifiedAction)
            }
            return next(action)
        }
    }
}
