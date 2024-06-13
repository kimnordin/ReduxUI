import XCTest
@testable import ReduxUI

class ReducerTests: XCTestCase {
    func testIncrementReducer() {
        let initialState = AppState(value: 0)
        let action = IncrementAction(add: 5)
        let expectedState = AppState(value: 5)
        
        let newState = appReducer(action, initialState)
        XCTAssertEqual(newState, expectedState, "Reducer should increment the state value.")
    }
    
    func testDecrementReducer() {
        let initialState = AppState(value: 5)
        let action = DecrementAction(subtract: 5)
        let expectedState = AppState(value: 0)
        
        let newState = appReducer(action, initialState)
        XCTAssertEqual(newState, expectedState, "Reducer should decrement the state value.")
    }
}
