import XCTest
@testable import ReduxUI

class StoreTests: XCTestCase {
    var store: Store<AppState>!

    override func setUpWithError() throws {
        super.setUp()
        store = Store(state: AppState(value: 0), reducer: appReducer)
    }

    func testDispatchAction() {
        store.dispatch(IncrementAction(add: 1))
        XCTAssertEqual(store.state.value, 1, "Store should update state based on the dispatched action.")
    }
}
