# PJCiOSApp

PJCiOSApp is a UIKit-based iOS starter app using an MVVM architecture.

## Architecture

- `Application`: app environment, dependency container, and navigation coordinator.
- `Core`: shared platform foundations such as binding, logging, networking, and persistence.
- `Features`: user-facing modules. Each feature owns its view controller and view model.
- `Shared`: reusable UI components and validation utilities.

## Development

Open `PJCiOSApp.xcodeproj` in Xcode 26 or later.

```bash
xcodebuild -project PJCiOSApp.xcodeproj -scheme PJCiOSApp -destination 'platform=iOS Simulator,name=iPhone 17' test
```

## Integrated Libraries

- Alamofire: app networking client.
- Kingfisher: remote image loading and caching.
- SnapKit: UIKit Auto Layout DSL.
- Sentry: crash and performance monitoring hook. Set `AppEnvironment.sentryDSN` before enabling uploads.
- SwiftLint: style checks through `.swiftlint.yml` and the Xcode build phase. If `swiftlint` is not installed locally, builds emit a warning and continue.
