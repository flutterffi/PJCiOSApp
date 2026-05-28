import Foundation

final class AppContainer {
    let environment: AppEnvironment
    let logger: AppLogging
    let apiClient: APIClienting
    let keyValueStore: KeyValueStoring
    let authService: AuthServicing

    init(environment: AppEnvironment) {
        self.environment = environment
        self.logger = AppLogger(subsystem: "com.flutterffi.PJCiOSApp")
        self.apiClient = URLSessionAPIClient(baseURL: environment.apiBaseURL)
        self.keyValueStore = UserDefaultsStore()
        self.authService = DemoAuthService()
    }

    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(authService: authService, validator: CredentialValidator(), logger: logger)
    }

    func makeHomeViewModel(session: UserSession) -> HomeViewModel {
        HomeViewModel(session: session, appName: environment.appName)
    }
}
