# Design System

Use the shared design system for all UI constants.

- `AppColor`: semantic colors backed by SwiftGen-generated assets where possible.
- `AppFont`: dynamic type-ready fonts.
- `AppSpacing`: spacing tokens for layout and component gaps.
- `AppRadius`: corner radius tokens.
- `AppLayout`: safe-area-aware layout helpers, screen ratio values, and design-size scaling.
- `AppNavigationStyle`: centralized navigation bar styling.
- `AppTextFieldStyle`: shared text field styling.

Design handoff should map design tokens into these files before feature screens are implemented.

Default design-size scaling uses a 375 x 812 baseline. Use `AppLayout.scaleWidth(_:)` and
`AppLayout.scaleHeight(_:)` for design values that need proportional scaling.

Use semantic colors first. For design handoff values, `AppColor.rgb(_:_:_:alpha:)` accepts
0-255 RGB channels and `AppColor.hex(_:)` accepts `#RGB`, `#ARGB`, `#RRGGBB`, and `#AARRGGBB`.
