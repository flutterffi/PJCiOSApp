import Foundation

struct HomeViewState: Equatable {
    let title: String
    let subtitle: String
}

final class HomeViewModel {
    let state: HomeViewState
    private let authService: AuthServicing

    init(session: UserSession, appName: String, authService: AuthServicing) {
        self.authService = authService
        self.state = HomeViewState(
            title: L10n.Home.welcome(session.displayName),
            subtitle: L10n.Home.subtitle(appName)
        )
    }

    func signOut() {
        authService.signOut()
    }
}
