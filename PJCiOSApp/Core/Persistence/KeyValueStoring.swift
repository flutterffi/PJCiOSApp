import Foundation

protocol KeyValueStoring {
    func string(forKey key: String) -> String?
    func set(_ value: String?, forKey key: String)
    func removeValue(forKey key: String)
}

final class UserDefaultsStore: KeyValueStoring {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func string(forKey key: String) -> String? {
        defaults.string(forKey: key)
    }

    func set(_ value: String?, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    func removeValue(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
