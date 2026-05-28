import Foundation
@testable import PJCiOSApp
import XCTest

final class APIClientTests: XCTestCase {
    func testBuildsRequestFromEnvironmentAndEndpoint() throws {
        let environment = NetworkEnvironment(
            name: .staging,
            baseURL: URL(string: "https://staging.example.com")!,
            defaultHeaders: ["Accept": "application/json"],
            timeoutInterval: 15,
            logsRequests: false
        )
        let client = AlamofireAPIClient(
            environment: environment,
            tokenProvider: TokenProviderSpy(token: "abc123")
        )

        let request = try client.makeURLRequest(ProfileEndpoint())

        XCTAssertEqual(request.url?.absoluteString, "https://staging.example.com/v1/profile?include=stats")
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.timeoutInterval, 15)
        XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"), "application/json")
        XCTAssertEqual(request.value(forHTTPHeaderField: "X-Feature"), "profile")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "Bearer abc123")
    }

    func testEncodesJSONBody() throws {
        let client = AlamofireAPIClient(environment: .development)
        let request = try client.makeURLRequest(LoginEndpoint(body: LoginBody(email: "user@example.com")))

        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertEqual(request.httpBody.flatMap { String(data: $0, encoding: .utf8) }, #"{"email":"user@example.com"}"#)
    }
}

private struct ProfileEndpoint: APIEndpoint {
    let path = "v1/profile"
    let method = HTTPMethod.get
    let queryItems = [URLQueryItem(name: "include", value: "stats")]
    let headers = ["X-Feature": "profile"]
}

private struct LoginEndpoint: APIEndpoint {
    let path = "v1/login"
    let method = HTTPMethod.post
    let body: Encodable?
    let requiresAuthentication = false
}

private struct LoginBody: Encodable {
    let email: String
}

private struct TokenProviderSpy: AuthorizationTokenProviding {
    let token: String?

    var authorizationToken: String? {
        token
    }
}
