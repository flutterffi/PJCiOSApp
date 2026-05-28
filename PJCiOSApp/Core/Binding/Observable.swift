import Foundation

final class Observable<Value> {
    typealias Observer = (Value) -> Void

    var value: Value {
        didSet {
            notifyObservers()
        }
    }

    private var observers: [UUID: Observer] = [:]

    init(_ value: Value) {
        self.value = value
    }

    @discardableResult
    func bind(fireImmediately: Bool = true, _ observer: @escaping Observer) -> UUID {
        let id = UUID()
        observers[id] = observer
        if fireImmediately {
            observer(value)
        }
        return id
    }

    func unbind(_ id: UUID) {
        observers[id] = nil
    }

    private func notifyObservers() {
        observers.values.forEach { $0(value) }
    }
}
