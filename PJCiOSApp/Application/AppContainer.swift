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
        let keyValueStore = UserDefaultsStore()
        self.keyValueStore = keyValueStore
        self.apiClient = AlamofireAPIClient(
            environment: environment.network,
            tokenProvider: keyValueStore,
            logger: logger
        )
        self.authService = DemoAuthService()
    }

    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(authService: authService, validator: CredentialValidator(), logger: logger)
    }

    func makeHomeViewModel(session: UserSession) -> HomeViewModel {
        HomeViewModel(session: session, appName: environment.appName)
    }
}
