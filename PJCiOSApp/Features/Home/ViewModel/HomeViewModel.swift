import Foundation

struct HomeViewState: Equatable {
    let title: String
    let subtitle: String
}

final class HomeViewModel {
    let state: HomeViewState

    init(session: UserSession, appName: String) {
        self.state = HomeViewState(
            title: L10n.Home.welcome(session.displayName),
            subtitle: L10n.Home.subtitle(appName)
        )
    }
}
