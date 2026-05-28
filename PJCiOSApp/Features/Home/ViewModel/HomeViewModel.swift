import Foundation

struct HomeViewState: Equatable {
    let title: String
    let subtitle: String
}

final class HomeViewModel {
    let state: HomeViewState

    init(session: UserSession, appName: String) {
        self.state = HomeViewState(
            title: "Welcome, \(session.displayName)",
            subtitle: "\(appName) is running on a UIKit MVVM foundation."
        )
    }
}
