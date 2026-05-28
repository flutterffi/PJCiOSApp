import Foundation

final class RegisterViewModel {
    enum State: Equatable {
        case idle
        case loading
        case registered(UserSession)
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

    func register(name: String, email: String, password: String) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            state.value = .failed("Please enter your name.")
            return
        }

        switch validator.validate(email: email, password: password) {
        case .success:
            break
        case .failure(let error):
            state.value = .failed(error.localizedDescription)
            return
        }

        state.value = .loading
        authService.register(name: trimmedName, email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let session):
                    self?.logger.info("User registered: \(session.userID)")
                    self?.state.value = .registered(session)
                case .failure(let error):
                    self?.logger.error("Registration failed: \(error.localizedDescription)")
                    self?.state.value = .failed(error.localizedDescription)
                }
            }
        }
    }
}
