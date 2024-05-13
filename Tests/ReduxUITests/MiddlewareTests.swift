import XCTest
@testable import ReduxUI

class MiddlewareTests: XCTestCase {
    var store: Store<AppState>!

    override func setUpWithError() throws {
        super.setUp()
        store = Store(state: AppState(value: 0), reducer: appReducer, middlewares: [appMiddleware])
    }

    func testMiddleware() {
        store.dispatch(IncrementAction(add: 1))
        XCTAssertEqual(store.state.value, 6, "Modifying middleware should alter the action before it reaches the reducer.")
    }
}
