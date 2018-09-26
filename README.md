# Segnify

[![Swift version](https://img.shields.io/badge/swift-4.2-brightgreen.svg)](https://img.shields.io/badge/swift-4.2-brightgreen.svg)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Segnify.svg)](https://img.shields.io/cocoapods/v/Segnify.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/nedap/Segnify)
[![Platform](https://img.shields.io/cocoapods/p/Segnify.svg)](https://alamofire.github.io/Alamofire)

An elegant, performing and fancy segmented component in Swift.

## Features

- [x] Textual segments: `TextSegment`
- [x] Image segments: `ImageSegment`
- [x] Segment selection indicator: `Segnicator`
- [x] Fully customizable, using the `TextSegmentConfiguration`, `ImageSegmentConfiguration`, `SegnicatorConfiguration` and `SegnifyConfiguration`
- [x] Modular components, based on `UIScrollView`, `UIStackView` and `UIButton`
- [x] Size & positioning based on Auto Layout
- [x] 100% code, 0% Storyboard / XIB

## Dependencies

Segnify makes use of the brilliant [SnapKit](https://snapkit.io) framework, a DSL to make Auto Layout easy on both iOS and OS X.

## Requirements

- iOS 9.3+
- Xcode 9.3+
- Swift 4.2+

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Segnify into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
platform :ios, '9.3'
use_frameworks!

target '<Your Target Name>' do
    pod 'Segnify', '~> 1.0'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](https://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Segnify into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "nedap/Segnify" ~> 1.0
```

Run `carthage update` to build the framework and drag the built `Segnify.framework` into your Xcode project.

## Example

WIP

## License

Copyright © 2018 N.V. Nederlandsche Apparatenfabriek (Nedap). All rights reserved.

See the [LICENSE](LICENSE.txt) file for more info.

## Change log

See the [CHANGELOG](CHANGELOG.md) file.



