import XCTest
@testable import PJCiOSApp

final class LoginViewModelTests: XCTestCase {
    func testInvalidCredentialsPublishFailure() {
        let viewModel = LoginViewModel(
            authService: AuthServiceSpy(result: .success(UserSession(userID: "1", displayName: "User", token: "token"))),
            validator: CredentialValidator(),
            logger: LoggerSpy()
        )

        viewModel.login(email: "invalid", password: "123")

        XCTAssertEqual(viewModel.state.value, .failed(ValidationError.invalidEmail.localizedDescription))
    }

    func testSuccessfulLoginPublishesAuthenticatedSession() {
        let session = UserSession(userID: "1", displayName: "User", token: "token")
        let viewModel = LoginViewModel(
            authService: AuthServiceSpy(result: .success(session)),
            validator: CredentialValidator(),
            logger: LoggerSpy()
        )
        let expectation = expectation(description: "Login completes")

        _ = viewModel.state.bind { state in
            if state == .authenticated(session) {
                expectation.fulfill()
            }
        }

        viewModel.login(email: "user@example.com", password: "secret1")

        wait(for: [expectation], timeout: 1.0)
    }
}

final class RegisterViewModelTests: XCTestCase {
    func testMissingNamePublishesFailure() {
        let viewModel = RegisterViewModel(
            authService: AuthServiceSpy(result: .success(UserSession(userID: "1", displayName: "User", token: "token"))),
            validator: CredentialValidator(),
            logger: LoggerSpy()
        )

        viewModel.register(name: " ", email: "user@example.com", password: "secret1")

        XCTAssertEqual(viewModel.state.value, .failed("Please enter your name."))
    }

    func testSuccessfulRegistrationPublishesRegisteredSession() {
        let session = UserSession(userID: "1", displayName: "User", token: "token")
        let viewModel = RegisterViewModel(
            authService: AuthServiceSpy(result: .success(session)),
            validator: CredentialValidator(),
            logger: LoggerSpy()
        )
        let expectation = expectation(description: "Registration completes")

        _ = viewModel.state.bind { state in
            if state == .registered(session) {
                expectation.fulfill()
            }
        }

        viewModel.register(name: "User", email: "user@example.com", password: "secret1")

        wait(for: [expectation], timeout: 1.0)
    }
}

final class ForgotPasswordViewModelTests: XCTestCase {
    func testInvalidEmailPublishesFailure() {
        let viewModel = ForgotPasswordViewModel(
            authService: AuthServiceSpy(result: .success(UserSession(userID: "1", displayName: "User", token: "token"))),
            logger: LoggerSpy()
        )

        viewModel.requestReset(email: "invalid")

        XCTAssertEqual(viewModel.state.value, .failed("Please enter a valid email address."))
    }

    func testSuccessfulResetPublishesSentMessage() {
        let message = "Password reset instructions were sent."
        let viewModel = ForgotPasswordViewModel(
            authService: AuthServiceSpy(
                result: .success(UserSession(userID: "1", displayName: "User", token: "token")),
                resetResult: .success(message)
            ),
            logger: LoggerSpy()
        )
        let expectation = expectation(description: "Reset completes")

        _ = viewModel.state.bind { state in
            if state == .sent(message) {
                expectation.fulfill()
            }
        }

        viewModel.requestReset(email: "user@example.com")

        wait(for: [expectation], timeout: 1.0)
    }
}

private final class AuthServiceSpy: AuthServicing {
    private let result: Result<UserSession, AuthError>
    private let resetResult: Result<String, AuthError>

    init(
        result: Result<UserSession, AuthError>,
        resetResult: Result<String, AuthError> = .success("Password reset instructions were sent.")
    ) {
        self.result = result
        self.resetResult = resetResult
    }

    func login(email: String, password: String, completion: @escaping (Result<UserSession, AuthError>) -> Void) {
        completion(result)
    }

    func register(
        name: String,
        email: String,
        password: String,
        completion: @escaping (Result<UserSession, AuthError>) -> Void
    ) {
        completion(result)
    }

    func requestPasswordReset(email: String, completion: @escaping (Result<String, AuthError>) -> Void) {
        completion(resetResult)
    }
}

private struct LoggerSpy: AppLogging {
    func info(_ message: String) {}
    func error(_ message: String) {}
}
