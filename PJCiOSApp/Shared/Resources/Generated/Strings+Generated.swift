// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Auth {
    /// Create Account
    internal static let createAccount = L10n.tr("Localizable", "auth.create_account", fallback: "Create Account")
    /// Email
    internal static let emailPlaceholder = L10n.tr("Localizable", "auth.email_placeholder", fallback: "Email")
    /// Forgot Password
    internal static let forgotPassword = L10n.tr("Localizable", "auth.forgot_password", fallback: "Forgot Password")
    /// Enter your email to receive reset instructions.
    internal static let forgotPasswordHint = L10n.tr("Localizable", "auth.forgot_password_hint", fallback: "Enter your email to receive reset instructions.")
    /// Sending reset instructions...
    internal static let forgotPasswordLoading = L10n.tr("Localizable", "auth.forgot_password_loading", fallback: "Sending reset instructions...")
    /// Email or password is incorrect.
    internal static let invalidCredentials = L10n.tr("Localizable", "auth.invalid_credentials", fallback: "Email or password is incorrect.")
    /// Use demo@pjcios.app and password for the local mock server.
    internal static let loginHint = L10n.tr("Localizable", "auth.login_hint", fallback: "Use demo@pjcios.app and password for the local mock server.")
    /// Signing in...
    internal static let loginLoading = L10n.tr("Localizable", "auth.login_loading", fallback: "Signing in...")
    /// Name
    internal static let namePlaceholder = L10n.tr("Localizable", "auth.name_placeholder", fallback: "Name")
    /// Password
    internal static let passwordPlaceholder = L10n.tr("Localizable", "auth.password_placeholder", fallback: "Password")
    /// Password reset instructions were sent to %@.
    internal static func passwordResetSent(_ p1: Any) -> String {
      return L10n.tr("Localizable", "auth.password_reset_sent", String(describing: p1), fallback: "Password reset instructions were sent to %@.")
    }
    /// Create a local mock account.
    internal static let registerHint = L10n.tr("Localizable", "auth.register_hint", fallback: "Create a local mock account.")
    /// Creating account...
    internal static let registerLoading = L10n.tr("Localizable", "auth.register_loading", fallback: "Creating account...")
    /// Reset Password
    internal static let resetPassword = L10n.tr("Localizable", "auth.reset_password", fallback: "Reset Password")
    /// Send Reset Link
    internal static let sendResetLink = L10n.tr("Localizable", "auth.send_reset_link", fallback: "Send Reset Link")
    /// Sign In
    internal static let signIn = L10n.tr("Localizable", "auth.sign_in", fallback: "Sign In")
  }
  internal enum Home {
    /// %@ is running on a UIKit MVVM foundation.
    internal static func subtitle(_ p1: Any) -> String {
      return L10n.tr("Localizable", "home.subtitle", String(describing: p1), fallback: "%@ is running on a UIKit MVVM foundation.")
    }
    /// Home
    internal static let title = L10n.tr("Localizable", "home.title", fallback: "Home")
    /// Welcome, %@
    internal static func welcome(_ p1: Any) -> String {
      return L10n.tr("Localizable", "home.welcome", String(describing: p1), fallback: "Welcome, %@")
    }
  }
  internal enum Validation {
    /// Please enter a valid email address.
    internal static let invalidEmail = L10n.tr("Localizable", "validation.invalid_email", fallback: "Please enter a valid email address.")
    /// Please enter your name.
    internal static let missingName = L10n.tr("Localizable", "validation.missing_name", fallback: "Please enter your name.")
    /// Password must be at least 6 characters.
    internal static let weakPassword = L10n.tr("Localizable", "validation.weak_password", fallback: "Password must be at least 6 characters.")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
