# SwiftyExpectations

[![SPM Compatible](https://img.shields.io/badge/Swift_Package_Manager-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/jaderfeijo/SwiftyExpectations/blob/master/LICENSE)

## Example

To run the example project, clone the repo. If using Swift Package Manager, open the project in Xcode and resolve the package dependencies.

## Requirements

* Swift 5.0 or later
* Xcode 11 or later

## Installation

### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager/) to install `SwiftyExpectations` by adding the proper description to your `Package.swift` file:

```swift
import PackageDescription

let package = Package(
	 name: "YOUR_PROJECT_NAME",
	 dependencies: [
		  .package(url: "https://github.com/jaderfeijo/SwiftyExpectations.git", from: "1.0.0")
	 ],
	 targets: [
		  .target(
				name: "YOUR_TARGET_NAME",
				dependencies: ["SwiftyExpectations"]),
	 ]
)
```

Then, run swift build whenever you get ready.

## Author

[Jader Feijo](https://twitter.com/jaderfeijo)

## License

SwiftyExpectations is available under the MIT license. See the LICENSE file for more info.