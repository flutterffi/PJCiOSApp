# Feature Module Template

Use this template when adding a new feature module.

```text
PJCiOSApp/Features/<ModuleName>/
  Model/
    <ModuleName>Service.swift
  View/
    <ScreenName>View.swift
  Controller/
    <ScreenName>ViewController.swift
  ViewModel/
    <ScreenName>ViewModel.swift
```

If a layer is intentionally empty, keep the directory with `.gitkeep`.

## Model

```swift
protocol ExampleServicing {
    func load(completion: @escaping (Result<ExampleModel, Error>) -> Void)
}

struct ExampleModel: Equatable {
    let title: String
}
```

## ViewModel

```swift
final class ExampleViewModel {
    enum State: Equatable {
        case idle
        case loading
        case loaded(ExampleModel)
        case failed(String)
    }

    let state = Observable<State>(.idle)

    private let service: ExampleServicing

    init(service: ExampleServicing) {
        self.service = service
    }
}
```

## View

```swift
import UIKit

final class ExampleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        backgroundColor = .systemBackground
    }
}
```

## Controller

```swift
import UIKit

final class ExampleViewController: UIViewController {
    private let viewModel: ExampleViewModel
    private let contentView = ExampleView()
    private var stateObservation: UUID?

    init(viewModel: ExampleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    private func bindViewModel() {
        stateObservation = viewModel.state.bind { [weak self] state in
            self?.render(state)
        }
    }

    private func render(_ state: ExampleViewModel.State) {
    }
}
```
