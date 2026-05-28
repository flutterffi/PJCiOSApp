# Design System

Use the shared design system for all UI constants.

- `AppColor`: semantic colors backed by SwiftGen-generated assets where possible.
- `AppFont`: dynamic type-ready fonts.
- `AppSpacing`: spacing tokens for layout and component gaps.
- `AppRadius`: corner radius tokens.
- `AppLayout`: safe-area-aware layout helpers for common screen structures.
- `AppNavigationStyle`: centralized navigation bar styling.
- `AppTextFieldStyle`: shared text field styling.

Design handoff should map design tokens into these files before feature screens are implemented.
