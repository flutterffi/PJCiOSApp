# PJCiOSApp

PJCiOSApp is a UIKit-based iOS starter app using an MVVM architecture.

## Architecture

- `Application`: app environment, dependency container, and navigation coordinator.
- `Core`: shared platform foundations such as binding, logging, networking, and persistence.
- `Features`: user-facing modules. Each module is split into `Model`, `View`, `Controller`, and `ViewModel`.
- `Shared`: reusable UI components and validation utilities.

See `Docs/Architecture.md` for the module rules, `Docs/FeatureModuleTemplate.md` when adding a new feature, `Docs/DesignSystem.md` for UI foundation rules, and `Docs/Swift6Migration.md` for Swift 6 readiness rules.

## Development

Open `PJCiOSApp.xcodeproj` in Xcode 26 or later. The minimum supported system is iOS 18.0.
The project remains on Swift 5 language mode (`SWIFT_VERSION = 5.0` in Xcode build settings), with code kept compatible with a Swift 5.9+ baseline and concurrency boundaries annotated to keep a future Swift 6 migration straightforward.

```bash
xcodebuild -project PJCiOSApp.xcodeproj -scheme PJCiOSApp -destination 'platform=iOS Simulator,name=iPhone 17' test
```

## Integrated Libraries

- Alamofire: app networking client.
- Kingfisher: remote image loading and caching.
- SnapKit: UIKit Auto Layout DSL.
- Sentry: crash and performance monitoring hook. Set `AppEnvironment.sentryDSN` before enabling uploads.
- SwiftLint: style checks through `.swiftlint.yml` and the Xcode build phase. If `swiftlint` is not installed locally, builds emit a warning and continue.

## Networking

Network requests are centralized behind `APIClienting`.

- `NetworkEnvironment`: owns base URL, default headers, timeout, and request logging.
- `APIEndpoint`: describes path, method, query items, custom headers, body, and auth requirement.
- `AlamofireAPIClient`: builds the request from the current environment, injects bearer tokens, executes with Alamofire, and maps errors.

Switch environments through `AppEnvironment.current` by assigning `network` to `.local`, `.development`, `.staging`, or `.production`.

The `.local` environment points to the Mockoon server in `flutterffi/PJCiOSMockServer`:

```text
http://localhost:3001
```

Start the local mock API with Docker:

```bash
cd /Users/platojobs/Desktop/GitHub/flutterffi/PJCiOSMockServer
docker compose up
```
