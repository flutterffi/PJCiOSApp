import Foundation

struct UserSession: Equatable {
    let userID: String
    let displayName: String
    let token: String
}

protocol AuthServicing {
    func login(email: String, password: String, completion: @escaping (Result<UserSession, AuthError>) -> Void)
    func register(
        name: String,
        email: String,
        password: String,
        completion: @escaping (Result<UserSession, AuthError>) -> Void
    )
    func requestPasswordReset(email: String, completion: @escaping (Result<String, AuthError>) -> Void)
}

enum AuthError: LocalizedError, Equatable {
    case invalidCredentials
    case network(String)

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Email or password is incorrect."
        case .network(let message):
            return message
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

    func register(
        name: String,
        email: String,
        password: String,
        completion: @escaping (Result<UserSession, AuthError>) -> Void
    ) {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.35) {
            completion(.success(UserSession(userID: UUID().uuidString, displayName: name, token: "demo-token")))
        }
    }

    func requestPasswordReset(email: String, completion: @escaping (Result<String, AuthError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.35) {
            completion(.success("Password reset instructions were sent to \(email)."))
        }
    }
}

final class RemoteAuthService: AuthServicing {
    private let apiClient: APIClienting
    private let tokenStore: KeyValueStoring

    init(apiClient: APIClienting, tokenStore: KeyValueStoring) {
        self.apiClient = apiClient
        self.tokenStore = tokenStore
    }

    func login(email: String, password: String, completion: @escaping (Result<UserSession, AuthError>) -> Void) {
        let endpoint = AuthEndpoint.login(email: email, password: password)
        apiClient.request(endpoint) { [tokenStore] (result: Result<LoginResponse, NetworkError>) in
            switch result {
            case .success(let response):
                tokenStore.set(response.token, forKey: StoreKey.authToken)
                completion(.success(response.user.session(token: response.token)))
            case .failure(let error):
                completion(.failure(.network(error.localizedDescription)))
            }
        }
    }

    func register(
        name: String,
        email: String,
        password: String,
        completion: @escaping (Result<UserSession, AuthError>) -> Void
    ) {
        let endpoint = AuthEndpoint.register(name: name, email: email, password: password)
        apiClient.request(endpoint) { [tokenStore] (result: Result<LoginResponse, NetworkError>) in
            switch result {
            case .success(let response):
                tokenStore.set(response.token, forKey: StoreKey.authToken)
                completion(.success(response.user.session(token: response.token)))
            case .failure(let error):
                completion(.failure(.network(error.localizedDescription)))
            }
        }
    }

    func requestPasswordReset(email: String, completion: @escaping (Result<String, AuthError>) -> Void) {
        apiClient.request(AuthEndpoint.forgotPassword(email: email)) { (result: Result<ForgotPasswordResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response.message))
            case .failure(let error):
                completion(.failure(.network(error.localizedDescription)))
            }
        }
    }
}

private enum AuthEndpoint: APIEndpoint {
    case login(email: String, password: String)
    case register(name: String, email: String, password: String)
    case forgotPassword(email: String)

    var path: String {
        switch self {
        case .login:
            return "auth/login"
        case .register:
            return "auth/register"
        case .forgotPassword:
            return "auth/forgot-password"
        }
    }

    var method: HTTPMethod {
        .post
    }

    var body: Encodable? {
        switch self {
        case .login(let email, let password):
            return LoginRequest(email: email, password: password)
        case .register(let name, let email, let password):
            return RegisterRequest(name: name, email: email, password: password)
        case .forgotPassword(let email):
            return ForgotPasswordRequest(email: email)
        }
    }

    var requiresAuthentication: Bool {
        false
    }
}

private struct LoginRequest: Encodable {
    let email: String
    let password: String
}

private struct RegisterRequest: Encodable {
    let name: String
    let email: String
    let password: String
}

private struct ForgotPasswordRequest: Encodable {
    let email: String
}

private struct LoginResponse: Decodable {
    let token: String
    let user: AuthUserResponse
}

private struct AuthUserResponse: Decodable {
    let id: String
    let name: String

    func session(token: String) -> UserSession {
        UserSession(userID: id, displayName: name, token: token)
    }
}

private struct ForgotPasswordResponse: Decodable {
    let message: String
}
