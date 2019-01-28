//
//  Int+Sugar.swift
//
//  Created by Jader Feijo.
//

import Foundation

public extension Int {

  /// A `TimeInterval` representing a single millisecond,
  /// multiplied by the value of `self`.
  ///
  /// ```
  /// let timeInterval = 3.milliseconds
  /// // timeInterval == 3 milliseconds
  /// ```
  ///
  /// ## See Also:
  /// `Int.millisecond`
  public var milliseconds: TimeInterval {
    return TimeInterval(Double(self) / 1000.0)
  }

  /// A `TimeInterval` representing a single millisecond,
  /// multiplied by the value of `self`.
  ///
  /// ```
  /// let timeInterval = 1.millisecond
  /// // timeInterval == 1 millisecond
  /// ```
  ///
  /// This property behaves the same as `milliseconds`, it exists
  /// only to provide the ability to write code in both plural and
  /// singular forms.
  ///
  /// ## See Also:
  /// `Int.milliseconds`
  public var millisecond: TimeInterval {
    return TimeInterval(Double(self) / 1000.0)
  }

  /// A `TimeInterval` representing a single second,
  /// multiplied by the value of `self`.
  ///
  /// ```
  /// let timeInterval = 3.seconds
  /// // timeInterval == 3 seconds
  /// ```
  ///
  /// ## See Also:
  /// `Int.second`
  public var seconds: TimeInterval {
    return TimeInterval(self)
  }

  /// A `TimeInterval` representing a single second,
  /// multiplied by the value of `self`.
  ///
  /// ```
  /// let timeInterval = 1.second
  /// // timeInterval == 1 second
  /// ```
  ///
  /// This property behaves the same as `seconds`, it exists
  /// only to provide the ability to write code in both plural and
  /// singular forms.
  ///
  /// ## See Also:
  /// `Int.seconds`
  public var second: TimeInterval {
    return TimeInterval(self)
  }

  /// Returns the value of `self`.
  ///
  /// This property has no effect, it exists only to allow the conveying
  /// of meaning through code in a way that resembles more closely the
  /// way meaning is conveyed in plain English.
  ///
  /// For example, by using this method you could write code as follows:
  ///
  /// Instead of writing:
  /// ```
  /// repeat(5) {
  ///   // do something 5 times
  /// }
  /// ```
  ///
  /// You could write:
  /// ```
  /// repeat(5.times) {
  ///   // do something 5 times
  /// }
  /// ```
  ///
  /// ## See Also:
  /// `Int.time`
  public var times: Int {
    return self
  }

  /// Returns the value of `self`.
  ///
  /// This property has no effect, it exists only to allow the conveying
  /// of meaning through code in a way that resembles more closely the
  /// way meaning is conveyed in plain English.
  ///
  /// For example, by using this method you could write code as follows:
  ///
  /// Instead of writing:
  /// ```
  /// repeat(5) {
  /// // do something 5 times
  /// }
  /// ```
  ///
  /// You could write:
  /// ```
  /// repeat(5.times) {
  /// // do something 5 times
  /// }
  /// ```
  ///
  /// This property behaves the same as `times`, it exists
  /// only to provide the ability to write code in both plural and
  /// singular forms.
  ///
  /// ## See Also:
  /// `Int.times`
  public var time: Int {
    return self
  }
}
