# Changelog
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [1.1.7] - 2021-05-10
#### Added

#### Fixed

#### Changed
- SEG-34: Upgrade package to Swift 5.4
- SEG-33: Drop support for iOS 10 and 11

## [1.1.6] - 2021-01-11
#### Added

#### Fixed

#### Changed
- SEG-26: [SPM] Add Support for Swift Package Manager

## [1.1.5] - 2020-10-27.
#### Updated
- Support for Xcode 12.1 and iOS 14 ([#25](https://github.com/nedap/segnify-ios/issues/25))

## [1.1.4] - 2020-04-14.
#### Fixed
- Fixed broken init in Xcode 11.4 ([#21](https://github.com/nedap/segnify-ios/issues/21))
- Fixed wrong safe area bottom constraint for `PageViewController` ([#22](https://github.com/nedap/segnify-ios/issues/22))

## [1.1.3] - 2020-01-10.
#### Updated
- Renamed the repository to [`segnify-ios`](https://github.com/nedap/segnify-ios/issues/17).

## [1.1.2] - 2018-12-20.
#### Fixed
- Fixed weak references to unowned objects ([#14](https://github.com/nedap/segnify-ios/issues/14))

## [1.1.1] - 2018-12-13.
#### Added
- Added `ForwardedEventsProtocol` ([#8](https://github.com/nedap/segnify-ios/issues/8))
- Added support for a [banner view](https://github.com/nedap/segnify-ios/issues/11).

#### Updated
- Extended the ['UIPageViewController' protocol implementations](https://github.com/nedap/segnify-ios/issues/8).

## [1.1.0] - 2018-11-28.
#### Added
- Added `PageViewController`, which replaces the usage of any content `UIScrollView`. `PageViewController` contains an implementation of `Segnify` and an instance of `UIPageViewController`, which are connected to each other.
- Added `PageViewControllerProtocol`, which can be used for customizing the UI of the `PageViewController` instance. Currently, the height of the `Segnify` instance inside the `PageViewController` instance and the background color of the `PageViewController` view can be configured.
- Added `SegnifyDataSourceProtocol`. The delegate which implements this protocol is the data source for the `Segnify` instance and `PageViewController` instance being used.
- Added `SegnifyEventsProtocol`. The delegate which implements this protocol will be notified about `Segment` selection changes of `Segnify`.
- Added `DefaultDelegates`, which offers a default implementation of almost all protocols.
- Added the example app `Segnified` inside the Xcode project, next to the `Segnify` framework, for improved development and testing processes.
- Added support for [infinite scrolling](https://github.com/nedap/segnify-ios/issues/3).

#### Removed
- Removed `BaseView`.
- Removed the `Example` applications, as they became obsolete because of the `Segnified` application directly next to the `Segnify` framework.

#### Updated
- Renamed all `*Configuration` protocols to `*Protocol`.
  
## [1.0.2] - 2018-10-25.
#### Added
- Added support for device orientation changes.

#### Fixed
- Fixed iPad support.

#### Updated
- Renamed `maximumSegmentWidth` to `segmentWidth`, so it better reflects its functionality.

## [1.0.1] - 2018-10-11.
#### Removed
- [SnapKit](https://snapkit.io) as external dependency.

#### Updated
- Replaced usage of [SnapKit](https://snapkit.io) with the native `NSLayoutConstraint` API.

## [1.0.0] - 2018-10-02.
#### Added
- Initial release of Segnify.

[1.1.7]: https://github.com/nedap/segnify-ios/compare/1.1.6...1.1.7
[1.1.6]: https://github.com/nedap/segnify-ios/compare/1.1.5...1.1.6
[1.1.5]: https://github.com/nedap/segnify-ios/compare/1.1.4...1.1.5
[1.1.4]: https://github.com/nedap/segnify-ios/compare/1.1.3...1.1.4
[1.1.3]: https://github.com/nedap/segnify-ios/compare/1.1.2...1.1.3
[1.1.2]: https://github.com/nedap/segnify-ios/compare/1.1.1...1.1.2
[1.1.1]: https://github.com/nedap/segnify-ios/compare/1.1.0...1.1.1
[1.1.0]: https://github.com/nedap/segnify-ios/compare/1.0.2...1.1.0
[1.0.2]: https://github.com/nedap/segnify-ios/compare/1.0.1...1.0.2
[1.0.1]: https://github.com/nedap/segnify-ios/compare/1.0.0...1.0.1
