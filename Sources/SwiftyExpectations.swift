//
// SwiftyExpectations.swift
//

import Foundation
import XCTest

/// A wrapper around `XCTExpectation` which provides
/// a nicer, more 'swifty' syntax with which to deal
/// with expectation in tests which are written in
/// Swift.
public class Expectation {

	/// The underlying `XCTestExpectation` instance managed by
	/// this `Expectation`.
	public let expectation: XCTestExpectation

	/// Whether or not this expectation has been fulfilled.
	/// `true` when fulfilled, `false` otherwise
	private(set) var isFulfilled = false

	/// The current fulfillment count for this expectation.
	/// This value gets incremented every time `fulfill()`
	/// is called.
	private(set) var fulfillmentCount: Int = 0

	/// Initialises a new instance of `Expectation` which
	/// wraps the specified `XCTestExpectation` instance.
	public init(_ expectation: XCTestExpectation) {
		self.expectation = expectation
	}

	/// Fulfills the wrapped `XCTExpectation` instance and sets
	/// `isFulfilled` to `true`.
	public func fulfill() {
		expectation.fulfill()
		fulfillmentCount += 1
		if fulfillmentCount >= expectation.expectedFulfillmentCount {
			isFulfilled = true
		}
	}

	/// Allows you to setup and fulfill expectations using
	/// Swift's closure syntax.
	///
	/// Expectations can be defined and fulfilled as such:
	/// ```
	/// let success = expect("success")
	/// success.do { finish in
	///   someAsyncMethod { result in
	///     finish {
	///       // handle results of `async`
	///       // once this block completes execution the
	///       // `success` expectation will be marked as
	///       // fulfilled
	///     }
	///   }
	/// }
	/// ```
	/// - Parameter function: The closure to execute which fulfills the expectation.
	public func `do`(closure: ExpectationClosure) {
		let finishClosure: ExpectationFinishClosure = { innerClosure in
			innerClosure()
			self.expectation.fulfill()
		}
		closure(finishClosure)
	}

	/// Allows you to setup and fulfill expectations using
	/// Swift's closure syntax.
	///
	/// Expectations can be defined and fulfilled as such:
	/// ```
	/// let success = expect("success")
	/// success.do { finish in
	///   someAsyncMethod { result in
	///     return finish {
	///       // handle results of `someAsyncMethod`
	///       // once this block completes execution the
	///       // `success` expectation will be marked as
	///       // fulfilled and the returned value will be
	///       // passed to the enclosing `finish`
	///       // closure.
	///       return .some("value")
	///     }
	///   }
	/// }
	/// ```
	/// - Parameter function: The function to execute which fulfills the expectation.
	public func `do`<T>(function: ExpectationFunctionClosure<T>) {
		let finishFunction: ExpectationFinishFunction<T> = { innerFunction -> T in
			defer {
				self.expectation.fulfill()
			}
			return innerFunction()
		}
		function(finishFunction)
	}

	/// Syntactic sugar, essentially the same as `do`.
	public func to(closure: ExpectationClosure) {
		self.do(closure: closure)
	}

	/// Syntactic sugar, essentially the same as `do`.
	public func to<T>(function: ExpectationFunctionClosure<T>) {
		self.do(function: function)
	}
}

// MARK: - XCTestCase: Swifty Expectations Methods -

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

}

// MARK: - TimeInterval: Default Intervals -

public extension TimeInterval {
	/// A tiny time interval of 1 millisecond.
	public static let tiny = 1.millisecond

	/// A small time interval of 500 milliseconds
	public static let small = 500.milliseconds

	/// A default time interval of 1 second.
	public static let `default` = 1.second

	/// A default timeout of 1 second.
	public static let timeout = 1.second
}

// MARK: - Closures -

/// A closure used as the inner closure type for an `ExpectationFinishClosure`.
public typealias InnerExpectationClosure = () -> Void

/// A closure which passes an `InnerExpectationClosure` to its receiver.
public typealias ExpectationFinishClosure = (InnerExpectationClosure) -> Void

/// A closure which passes an escaping `ExpectationFinishClosure` to its receiver.
public typealias ExpectationClosure = (@escaping ExpectationFinishClosure) -> Void

/// A function used as the inner closure type for an `ExpectationFinishFunction` which returns `T`.
public typealias InnerExpectationFunction<T> = () -> T

/// A function which passes an `InnerExceptionFunction<T>` to its receiver and returns `T`.
public typealias ExpectationFinishFunction<T> = (InnerExpectationFunction<T>) -> T

/// A closure which passes an escaping `ExpectationFinishFunction<T>` to its receiver and returns Void.
public typealias ExpectationFunctionClosure<T> = (@escaping ExpectationFinishFunction<T>) -> Void
