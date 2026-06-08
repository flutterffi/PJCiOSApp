import Foundation
import Security

final class KeychainStore: KeyValueStoring, @unchecked Sendable {
    private let service: String

    init(service: String = Bundle.main.bundleIdentifier ?? "com.flutterffi.PJCiOSApp") {
        self.service = service
    }

    func string(forKey key: String) -> String? {
        var query = baseQuery(for: key)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnData as String] = true

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess, let data = item as? Data else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func set(_ value: String?, forKey key: String) {
        guard let value else {
            removeValue(forKey: key)
            return
        }

        let encodedValue = Data(value.utf8)
        let query = baseQuery(for: key)
        let attributes: [String: Any] = [kSecValueData as String: encodedValue]
        let updateStatus = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)

        guard updateStatus == errSecItemNotFound else {
            return
        }

        var addQuery = query
        addQuery[kSecValueData as String] = encodedValue
        addQuery[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        SecItemAdd(addQuery as CFDictionary, nil)
    }

    func removeValue(forKey key: String) {
        SecItemDelete(baseQuery(for: key) as CFDictionary)
    }

    private func baseQuery(for key: String) -> [String: Any] {
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]
    }
}

extension KeychainStore: AuthorizationTokenProviding {
    var authorizationToken: String? {
        string(forKey: StoreKey.authToken)
    }
}
