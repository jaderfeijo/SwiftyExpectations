//
//  Double+Sugar.swift
//
//  Created by Jader Feijo.
//

import Foundation

extension Double {

  /// A `TimeInterval` representing a single millisecond,
  /// multiplied by the value of `self`.
  ///
  /// ```
  /// let timeInterval = 3.0.milliseconds
  /// // timeInterval == 3 milliseconds
  /// ```
  ///
  /// ## See Also:
  /// `Double.millisecond`
  var milliseconds: TimeInterval {
    return TimeInterval(self / 1000.0)
  }

  /// A `TimeInterval` representing a single millisecond,
  /// multiplied by the value of `self`.
  ///
  /// ```
  /// let timeInterval = 1.0.millisecond
  /// // timeInterval == 1 millisecond
  /// ```
  ///
  /// This property behaves the same as `milliseconds`, it exists
  /// only to provide the ability to write code in both plural and
  /// singular forms.
  ///
  /// ## See Also:
  /// `Double.milliseconds`
  var millisecond: TimeInterval {
    return TimeInterval(self / 1000.0)
  }

  /// A `TimeInterval` representing a single second,
  /// multiplied by the value of `self`.
  ///
  /// ```
  /// let timeInterval = 3.0.seconds
  /// // timeInterval == 3 seconds
  /// ```
  ///
  /// ## See Also:
  /// `Double.second`
  var seconds: TimeInterval {
    return TimeInterval(self)
  }

  /// A `TimeInterval` representing a single second,
  /// multiplied by the value of `self`.
  ///
  /// ```
  /// let timeInterval = 1.0.second
  /// // timeInterval == 1 second
  /// ```
  ///
  /// This property behaves the same as `seconds`, it exists
  /// only to provide the ability to write code in both plural and
  /// singular forms.
  ///
  /// ## See Also:
  /// `Double.seconds`
  var second: TimeInterval {
    return TimeInterval(self)
  }
}
