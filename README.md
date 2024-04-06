<p align="center">
  <img height="160" src="Assets/logo.png" />
</p>

# SSKit

[![CocoaPods](https://img.shields.io/cocoapods/v/SSSKit.svg)](https://cocoapods.org/pods/SSSKit)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

## Status

This project is actively under development, and is being used. We consider it ready for production use.

## Installation

### Swift Package Manager

_Note: Instructions below are for using **SPM** without the Xcode UI. It's the easiest to go to your Project Settings -> Swift Packages and add SSKit from there._

To integrate using Apple's Swift package manager, without Xcode integration, add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/sncsuunc/SSKit.git", .upToNextMajor(from: "1.0.2"))
```

### CocoaPods

For SSKit, use the following entry in your Podfile:

```rb
pod 'SSSKit', '~> 15.0'
```

Then run `pod install`.

In any file you'd like to use SSKit in, don't forget to
import the framework with `import SSKit`.

## Usage

```swift
import SSKit

/*
 NOW YOU CAN ACCESS ALL METHOD AND EXTENSIONS
*/

```

## License

SSKit is released under an MIT license. See [LICENSE](https://github.com/sncsuunc/SSKit/blob/main/LICENSE) for more information.