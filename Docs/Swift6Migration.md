# Swift 6 Migration Notes

PJCiOSApp currently builds in Swift 5 language mode (`SWIFT_VERSION = 5.0` in Xcode build settings) with strict concurrency checking enabled. Treat Swift 5.9+ as the source compatibility baseline while keeping the project ready for a future Swift 6 language mode switch.

Keep new code migration-ready by following these rules:

- Mark data that crosses asynchronous boundaries as `Sendable`.
- Use `@Sendable` for escaping completion closures that may run off the caller's executor.
- Keep UI-facing coordinators and view models on `@MainActor`.
- Avoid storing arbitrary `Error` values inside app error enums; store stable sendable messages or typed sendable errors instead.
- Validate third-party package Swift 6 compatibility before switching the project `SWIFT_VERSION` setting to `6.0`.
