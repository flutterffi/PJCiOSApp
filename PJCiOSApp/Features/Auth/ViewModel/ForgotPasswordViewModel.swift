import Foundation

final class ForgotPasswordViewModel {
    enum State: Equatable {
        case idle
        case loading
        case sent(String)
        case failed(String)
    }

    let state = Observable<State>(.idle)

    private let authService: AuthServicing
    private let logger: AppLogging

    init(authService: AuthServicing, logger: AppLogging) {
        self.authService = authService
        self.logger = logger
    }

    func requestReset(email: String) {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmedEmail.contains("@"), trimmedEmail.contains(".") else {
            state.value = .failed("Please enter a valid email address.")
            return
        }

        state.value = .loading
        authService.requestPasswordReset(email: trimmedEmail) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    self?.logger.info("Password reset requested.")
                    self?.state.value = .sent(message)
                case .failure(let error):
                    self?.logger.error("Password reset failed: \(error.localizedDescription)")
                    self?.state.value = .failed(error.localizedDescription)
                }
            }
        }
    }
}
