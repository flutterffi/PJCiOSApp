import UIKit

enum AppNavigationStyle {
    static func apply(to navigationController: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColor.background
        appearance.titleTextAttributes = [.foregroundColor: AppColor.textPrimary]
        appearance.largeTitleTextAttributes = [.foregroundColor: AppColor.textPrimary]

        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.tintColor = AppColor.primary
        navigationController.navigationBar.prefersLargeTitles = false
    }
}
