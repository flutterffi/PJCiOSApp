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
