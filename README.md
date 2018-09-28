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
- [x] Works very well with a `UIScrollView` instance as content view.
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

## Usage

1) Create a `Segnify` instance.

```swift
let segnify = Segnify()
```

2) Add it to your view of choice, and make sure it looks good, i.e. by applying some Auto Layout constraints. In the code example below, this has been done using [SnapKit](https://snapkit.io).

```swift
view.addSubview(segnify)
segnify.snp.makeConstraints { make in
    make.leading.trailing.equalToSuperview()
    make.top.equalTo(self.topLayoutGuide.snp.bottom)
    make.height.equalTo(75.0)
}
```

3) Implement the `TextSegmentConfiguration` protocol for customizing textual segments, or the `ImageSegmentConfiguration` protocol for customizing image segments. In the example below, the `TextSegmentConfiguration` protocol has been implemented in the `TextSegmentConfigurator` struct.

Make sure you import the `Segnify` framework.

```swift
import Segnify

struct TextSegmentConfigurator: TextSegmentConfiguration {

    var font: UIFont? = .systemFont(ofSize: 17.0)
    
    func textColor(for state: UIControl.State) -> UIColor? {
        switch state {
        case .highlighted, .selected:
            return .lightGray
        default:
            return .white
        }
    }
    
    func segmentBackgroundColor(for state: UIControl.State) -> UIColor? {
        switch state {
        case .highlighted, .selected,  [.selected, .highlighted]:
            return UIColor(red: 39.0/255.0, green: 59.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        default:
            return .clear
        }
    }
}
```

4) Initialize `TextSegment` (or `ImageSegment`) instances using the `init(with:configuration:)` convenience init method and the configurator you've created.

```swift
let segmentTitles = ["Segment 1", "Segment 2", "Segment 3"]
let textSegmentConfigurator = TextSegmentConfigurator()
let segments = segmentTitles.map({ TextSegment(with: $0, configuration: textSegmentConfigurator) })
```

5) If a visual indicator for selected segments is desired, implement the `SegnicatorConfiguration` protocol. In the example below, this has been done in the `SegnicatorConfigurator` struct. Auto Layout constraints have been applied using [SnapKit](https://snapkit.io).

By using the `SegnicatorSubviewsClosure` typealias, subviews and Auto Layout constraints can easily be added, as it takes a reference to a `Segnicator` instance as a parameter. See the example below.

Again, make sure you import the `Segnify` framework.

```swift
import Segnify

struct SegnicatorConfigurator: SegnicatorConfiguration {
    
    var isUpdatingOffsetAtScrolling: Bool? = true
    
    var segnicatorSubviewsClosure: SegnicatorSubviewsClosure? = { segnicator in
        // Create a white, horizontal indicator view.
        let whiteIndicatorView = UIView()
        whiteIndicatorView.backgroundColor = .white
        
        // Add it to the segnicator and give it the correct layout.
        segnicator.addSubview(whiteIndicatorView)
        whiteIndicatorView.snp.makeConstraints({ make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(2.0)
        })
    }
}
```

6) Initialize a `Segnicator` instance using the `init(with:)` convenience init method and the configurator you've created. 

```swift
let segnicatorConfigurator = SegnicatorConfigurator()
let segnicator = Segnicator(with: segnicatorConfigurator)
```

7) Implement the `SegnifyConfiguration` protocol in order to customize the `Segnify` instance. See the example below.

Again, make sure you import the `Segnify` framework.

```swift
import Segnify

struct SegnifyConfigurator: SegnifyConfiguration {
    
    var equallyFillHorizontalSpace: Bool? = false
    
    var isBouncingHorizontally: Bool? = true
    
    var maximumSegmentWidth: CGFloat? = 150.0
    
    var segnifyBackgroundColor: UIColor? = UIColor(red: 76.0/255.0, green: 114.0/255.0, blue: 128.0/255.0, alpha: 1.0)
}
```

8) Segnify works very well with another `UIScrollView` instance, acting as a content view. The `contentScrollView` property and the `SegnifyDelegate` protocol can be used in that case. For more information, check the documentation comments and the [Example](https://github.com/nedap/Segnify/tree/master/Example) application.

Eventually, configure and populate the `Segnify` instance.

```swift
let segnifyConfigurator = SegnifyConfigurator()
segnify.contentScrollView = contentScrollView
segnify.delegate = self
segnify.populate(with: segments,
                 segnicator: segnicator,
                 segnifyConfiguration: segnifyConfigurator)
```

9) Enjoy!

## License

Copyright © 2018 N.V. Nederlandsche Apparatenfabriek (Nedap). All rights reserved.

See the [LICENSE](LICENSE) file for more info.

## Change log

See the [CHANGELOG](CHANGELOG.md) file.



