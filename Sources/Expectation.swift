//
//  SwiftyExpectations
//

import Foundation
import XCTest

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
	private(set)
	public var isFulfilled = false

	/// The current fulfillment count for this expectation.
	/// This value gets incremented every time `fulfill()`
	/// is called.
	private(set)
	public var fulfillmentCount: Int = 0

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
