@testable import PJCiOSApp
import XCTest

final class RemoteAuthServiceTests: XCTestCase {
    func testLoginStoresTokenAndReturnsSession() {
        let tokenStore = KeyValueStoreSpy()
        let service = RemoteAuthService(
            apiClient: APIClientSpy(response: LoginResponseFixture.successData),
            tokenStore: tokenStore
        )
        let expectation = expectation(description: "Login completes")

        service.login(email: "demo@pjcios.app", password: "password") { result in
            guard case .success(let session) = result else {
                XCTFail("Expected login success.")
                return
            }

            XCTAssertEqual(session.userID, "user-001")
            XCTAssertEqual(session.displayName, "Plato Jobs")
            XCTAssertEqual(session.token, "mock-token-123")
            XCTAssertEqual(tokenStore.values[StoreKey.authToken], "mock-token-123")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testRegisterStoresTokenAndReturnsSession() {
        let tokenStore = KeyValueStoreSpy()
        let service = RemoteAuthService(
            apiClient: APIClientSpy(response: LoginResponseFixture.registerData),
            tokenStore: tokenStore
        )
        let expectation = expectation(description: "Register completes")

        service.register(name: "Plato Jobs", email: "demo@pjcios.app", password: "password") { result in
            guard case .success(let session) = result else {
                XCTFail("Expected register success.")
                return
            }

            XCTAssertEqual(session.userID, "user-registered-001")
            XCTAssertEqual(session.displayName, "Plato Jobs")
            XCTAssertEqual(session.token, "mock-token-registered-123")
            XCTAssertEqual(tokenStore.values[StoreKey.authToken], "mock-token-registered-123")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testPasswordResetReturnsMessage() {
        let service = RemoteAuthService(
            apiClient: APIClientSpy(response: LoginResponseFixture.passwordResetData),
            tokenStore: KeyValueStoreSpy()
        )
        let expectation = expectation(description: "Password reset completes")

        service.requestPasswordReset(email: "demo@pjcios.app") { result in
            XCTAssertEqual(try? result.get(), "Password reset instructions were sent to demo@pjcios.app.")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

private enum LoginResponseFixture {
    static let successData = Data("""
    {
      "token": "mock-token-123",
      "user": {
        "id": "user-001",
        "name": "Plato Jobs",
        "email": "demo@pjcios.app",
        "avatarURL": "https://dummyjson.com/icon/emilys/128"
      }
    }
    """.utf8)

    static let registerData = Data("""
    {
      "token": "mock-token-registered-123",
      "user": {
        "id": "user-registered-001",
        "name": "Plato Jobs",
        "email": "demo@pjcios.app",
        "avatarURL": "https://dummyjson.com/icon/emilys/128"
      }
    }
    """.utf8)

    static let passwordResetData = Data("""
    {
      "message": "Password reset instructions were sent to demo@pjcios.app."
    }
    """.utf8)
}

private final class APIClientSpy: APIClienting {
    private let response: Data

    init(response: Data) {
        self.response = response
    }

    func request<T: Decodable & Sendable>(
        _ endpoint: APIEndpoint,
        completion: @Sendable @escaping (Result<T, NetworkError>) -> Void
    ) {
        do {
            completion(.success(try JSONDecoder().decode(T.self, from: response)))
        } catch {
            completion(.failure(.decoding(error.localizedDescription)))
        }
    }
}

private final class KeyValueStoreSpy: KeyValueStoring, @unchecked Sendable {
    var values: [String: String] = [:]

    func string(forKey key: String) -> String? {
        values[key]
    }

    func set(_ value: String?, forKey key: String) {
        values[key] = value
    }

    func removeValue(forKey key: String) {
        values[key] = nil
    }
}
