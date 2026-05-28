import Foundation

final class LoginViewModel {
    enum State: Equatable {
        case idle
        case loading
        case authenticated(UserSession)
        case failed(String)
    }

    let state = Observable<State>(.idle)

    private let authService: AuthServicing
    private let validator: CredentialValidator
    private let logger: AppLogging

    init(authService: AuthServicing, validator: CredentialValidator, logger: AppLogging) {
        self.authService = authService
        self.validator = validator
        self.logger = logger
    }

    func login(email: String, password: String) {
        switch validator.validate(email: email, password: password) {
        case .success:
            break
        case .failure(let error):
            state.value = .failed(error.localizedDescription)
            return
        }

        state.value = .loading
        authService.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let session):
                    self?.logger.info("User authenticated: \(session.userID)")
                    self?.state.value = .authenticated(session)
                case .failure(let error):
                    self?.logger.error("Login failed: \(error.localizedDescription)")
                    self?.state.value = .failed(error.localizedDescription)
                }
            }
        }
    }
}
