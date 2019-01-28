import XCTest
import SwiftyExpectations

class SwiftyExpectationTests: XCTestCase {

	func testFulfilledExpectation() {
		let expectation = expect("test")
		expectation.fulfill()
		waitForExpectations(timeout: .default)
	}

}
