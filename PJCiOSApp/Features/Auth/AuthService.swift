import Foundation

struct UserSession: Equatable {
    let userID: String
    let displayName: String
    let token: String
}

protocol AuthServicing {
    func login(email: String, password: String, completion: @escaping (Result<UserSession, AuthError>) -> Void)
}

enum AuthError: LocalizedError, Equatable {
    case invalidCredentials

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Email or password is incorrect."
        }
    }
}

final class DemoAuthService: AuthServicing {
    func login(email: String, password: String, completion: @escaping (Result<UserSession, AuthError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.35) {
            let name = email.split(separator: "@").first.map(String.init) ?? "User"
            completion(.success(UserSession(userID: UUID().uuidString, displayName: name, token: "demo-token")))
        }
    }
}
