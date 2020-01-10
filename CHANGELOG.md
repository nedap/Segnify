# Changelog
All notable changes to this project will be documented in this file.
`segnify-ios` adheres to [Semantic Versioning](https://semver.org/).

#### 1.x Releases
- `1.1.x` Releases - [1.1.0](#110) | [1.1.1](#111) | [1.1.2](#112)
- `1.0.x` Releases - [1.0.0](#100) | [1.0.1](#101) | [1.0.2](#102)

---
## [Unreleased]

#### Updated
- Renamed the repository to [`segnify-ios`](https://github.com/nedap/segnify-ios/issues/17).
	- Updated by [Bart Hopster](https://github.com/barthopster).

## [1.1.2](https://github.com/nedap/segnify-ios/releases/tag/1.1.2)
Released on 2018-12-20.

#### Fixed

- Fixed weak references to unowned objects ([#14](https://github.com/nedap/segnify-ios/issues/14))
  - Fixed by [Bart Hopster](https://github.com/barthopster).

## [1.1.1](https://github.com/nedap/segnify-ios/releases/tag/1.1.1)
Released on 2018-12-13.

#### Added

- Added `ForwardedEventsProtocol` ([#8](https://github.com/nedap/segnify-ios/issues/8))
- Added support for a [banner view](https://github.com/nedap/segnify-ios/issues/11).
  - Added by [Bart Hopster](https://github.com/barthopster).

#### Updated

- Extended the ['UIPageViewController' protocol implementations](https://github.com/nedap/segnify-ios/issues/8).
	- Added by [Bart Hopster](https://github.com/barthopster).

## [1.1.0](https://github.com/nedap/segnify-ios/releases/tag/1.1.0)
Released on 2018-11-28.

#### Added

- Added `PageViewController`, which replaces the usage of any content `UIScrollView`. `PageViewController` contains an implementation of `Segnify` and an instance of `UIPageViewController`, which are connected to each other.
- Added `PageViewControllerProtocol`, which can be used for customizing the UI of the `PageViewController` instance. Currently, the height of the `Segnify` instance inside the `PageViewController` instance and the background color of the `PageViewController` view can be configured.
- Added `SegnifyDataSourceProtocol`. The delegate which implements this protocol is the data source for the `Segnify` instance and `PageViewController` instance being used.
- Added `SegnifyEventsProtocol`. The delegate which implements this protocol will be notified about `Segment` selection changes of `Segnify`.
- Added `DefaultDelegates`, which offers a default implementation of almost all protocols.
- Added the example app `Segnified` inside the Xcode project, next to the `Segnify` framework, for improved development and testing processes.
- Added support for [infinite scrolling](https://github.com/nedap/segnify-ios/issues/3).
  - Added by [Bart Hopster](https://github.com/barthopster).

#### Removed
- Removed `BaseView`.
- Removed the `Example` applications, as they became obsolete because of the `Segnified` application directly next to the `Segnify` framework.
  - Removed by [Bart Hopster](https://github.com/barthopster).

#### Updated
- Renamed all `*Configuration` protocols to `*Protocol`.
  - Updated by [Bart Hopster](https://github.com/barthopster).
  
## [1.0.2](https://github.com/nedap/segnify-ios/releases/tag/1.0.2)
Released on 2018-10-25.

#### Added

- Added support for device orientation changes.
  - Added by [Bart Hopster](https://github.com/barthopster).

#### Fixed

- Fixed iPad support.
  - Fixed by [Bart Hopster](https://github.com/barthopster).

#### Updated
- Renamed `maximumSegmentWidth` to `segmentWidth`, so it better reflects its functionality.
  - Updated by [Bart Hopster](https://github.com/barthopster).

## [1.0.1](https://github.com/nedap/segnify-ios/releases/tag/1.0.1)
Released on 2018-10-11.

#### Removed

- [SnapKit](https://snapkit.io) as external dependency.
  - Removed by [Bart Hopster](https://github.com/barthopster).

#### Updated
- Replaced usage of [SnapKit](https://snapkit.io) with the native `NSLayoutConstraint` API.
  - Updated by [Bart Hopster](https://github.com/barthopster).

## [1.0.0](https://github.com/nedap/segnify-ios/releases/tag/1.0.0)
Released on 2018-10-02.

#### Added
- Initial release of Segnify.
  - Added by [Bart Hopster](https://github.com/barthopster).
