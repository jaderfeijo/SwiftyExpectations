//
//  SwiftyExpectations
//

import Foundation

public extension TimeInterval {
	/// A tiny time interval of 1 millisecond.
	static let tiny = 1.millisecond

	/// A small time interval of 500 milliseconds
	static let small = 500.milliseconds

	/// A default time interval of 1 second.
	static let `default` = 1.second

	/// A default timeout of 1 second.
	static let timeout = 1.second
}
