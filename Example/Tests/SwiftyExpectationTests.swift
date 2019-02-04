import XCTest
import SwiftyExpectations

class SwiftyExpectationTests: XCTestCase {

	func testFulfilledExpectation() {
		let expectation = expect("expectation")

		DispatchQueue.main.async {
			expectation.fulfill()
		}

		waitForExpectations(timeout: .default)
	}

	func testWaitMultipleExpectations() {
		let firstExpectation = expect("first expectation")
		let secondExpectation = expect("second expectation")

		DispatchQueue.main.async {
			firstExpectation.fulfill()
		}
		DispatchQueue.main.async {
			secondExpectation.fulfill()
		}

		wait(for: firstExpectation, secondExpectation, timeout: .default)
	}

}
