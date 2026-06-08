@testable import PJCiOSApp
import XCTest

final class KeychainStoreTests: XCTestCase {
    private var store: KeychainStore!
    private var service: String!

    override func setUp() {
        super.setUp()
        service = "com.flutterffi.PJCiOSApp.tests.\(UUID().uuidString)"
        store = KeychainStore(service: service)
    }

    override func tearDown() {
        store.removeValue(forKey: StoreKey.authToken)
        store = nil
        service = nil
        super.tearDown()
    }

    func testStoresAndReadsString() {
        store.set("token-123", forKey: StoreKey.authToken)

        XCTAssertEqual(store.string(forKey: StoreKey.authToken), "token-123")
        XCTAssertEqual(store.authorizationToken, "token-123")
    }

    func testUpdatesExistingString() {
        store.set("old-token", forKey: StoreKey.authToken)
        store.set("new-token", forKey: StoreKey.authToken)

        XCTAssertEqual(store.string(forKey: StoreKey.authToken), "new-token")
    }

    func testRemovesString() {
        store.set("token-123", forKey: StoreKey.authToken)
        store.removeValue(forKey: StoreKey.authToken)

        XCTAssertNil(store.string(forKey: StoreKey.authToken))
    }
}
