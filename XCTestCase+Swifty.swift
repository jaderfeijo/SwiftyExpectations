//
//  SwiftyExpectations
//

import Foundation
import XCTest

public extension XCTestCase {

	/// A simple closure type with no parameters and no return value.
	public typealias VoidClosure = () -> Void

	/// Returns a new instance of `Expectation` with a wrapped
	///  instance of `XCTExpectation` containing the specified
	///  `description`.
	///
	/// ## See Also
	/// `Expectation.fulfill()`
	///
	/// - Parameter description: The expectation's description.
	///
	/// - Returns: The new `Expectation` instance.
	public func expect(_ description: String) -> Expectation {
		return Expectation(
			expectation(
				description: description
			)
		)
	}

	///  Returns a new instance of `Expectation` with a wrapped
	///  instance of `XCTExpectation` containing the specified
	///  `description` which is limited by `count` times it can
	/// be fulfilled.
	///
	///  Calling `fulfill()` on the returned `Expectation` more than
	///  `count` times causes the underlying `XCTExpectation ` to fail.
	///
	/// ## See Also
	/// `Expectation.fulfill()`
	///
	/// - Parameter description: The expectation's description.
	/// - Parameter count: The number of times `fulfill()` can be called
	/// on the new `Expectation` before it fails.
	///
	/// - Returns: The new `Expectation` instance.
	public func expect(_ description: String, count: UInt) -> Expectation {
		let e = expectation(description: description)
		e.assertForOverFulfill = true
		e.expectedFulfillmentCount = Int(count)
		return Expectation(e)
	}

	/// This method is an alias for `expect(_ description: String, count: UInt)`,
	/// provided for convinence so `Int` literals don't need to be wrapped
	/// inside `UInt()` when calling `expect`.
	///
	/// This alias makes it possible to write code like this:
	/// ```
	/// expect("callback", count: 2)
	/// ```
	///
	/// Without it, you would have to write:
	/// ```
	/// expect("callback", count: UInt(2))
	/// ```
	///
	/// ## See Also:
	/// `expect(_ description: String, count: UInt) -> Expectation`
	///
	/// - Parameter description: The expectation's description.
	/// - Parameter count: The number of times `fulfill()` can be called
	/// on the new `Expectation` before it fails.
	///
	/// - Returns: The new `Expectation` instance.
	public func expect(_ description: String, count: Int) -> Expectation {
		return expect(description, count: UInt(count))
	}

	/// Returns an inverted `Expectation` instance which wraps
	/// around an `XCTExpectation` whose `isInverted` property is
	/// set to `true`.
	///
	/// The returned expectation is expected to **not** be fulfilled.
	/// If the expectation is fulfilled, the test will fail.
	///
	/// - Parameter description: The expectation's description.
	/// - Returns: The new `Expectation` instance.
	public func dontExpect(_ description: String) -> Expectation {
		let e = expectation(
			description: description
		)
		e.isInverted = true
		return Expectation(e)
	}

	/// Waits for the specified `Expectation`, for the specified `timeout`.
	///
	/// This method acts as a wrapper around the
	/// `wait(for: [XCTExpectation], timeout: TimeInterval)` method, allowing
	/// for a simpler syntax to be used whenever a single expectation is to be
	/// waited on.
	///
	/// Example:
	/// ```
	/// wait(for: completed)
	/// ```
	///
	/// Or:
	/// ```
	/// wait(for: completed, timeout: 5.seconds)
	/// ```
	///
	/// - Parameters:
	///   - expectation: The `Expectation` to be waited on.
	///   - timeout: The timeout after which the expectation fails.
	public func wait(for expectation: Expectation, timeout: TimeInterval = .default) {
		wait(for: [expectation.expectation], timeout: timeout)
	}
}
