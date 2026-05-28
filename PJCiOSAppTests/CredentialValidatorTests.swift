@testable import PJCiOSApp
import XCTest

final class CredentialValidatorTests: XCTestCase {
    func testValidCredentialsPassValidation() {
        let result = CredentialValidator().validate(email: "user@example.com", password: "secret1")
        guard case .success = result else {
            return XCTFail("Expected credentials to be valid.")
        }
    }

    func testInvalidEmailFailsValidation() {
        let result = CredentialValidator().validate(email: "invalid", password: "secret1")
        guard case .failure(.invalidEmail) = result else {
            return XCTFail("Expected invalid email validation error.")
        }
    }

    func testShortPasswordFailsValidation() {
        let result = CredentialValidator().validate(email: "user@example.com", password: "123")
        guard case .failure(.weakPassword) = result else {
            return XCTFail("Expected weak password validation error.")
        }
    }
}
