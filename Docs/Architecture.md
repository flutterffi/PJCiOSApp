# PJCiOSApp Architecture

PJCiOSApp uses a UIKit MVVM architecture. Feature code is organized by module first, then by layer.

## Top-Level Structure

```text
PJCiOSApp/
  App/
  Application/
  Core/
  Features/
  Shared/
  Resources/
```

- `App`: UIKit app entry points.
- `Application`: dependency container, environment selection, and navigation coordinators.
- `Core`: reusable app infrastructure such as binding, logging, networking, and persistence.
- `Features`: product modules, organized by the four-layer feature structure below.
- `Shared`: reusable UI controls, validators, and feature-agnostic helpers.
- `Resources`: assets and app resources.

## Feature Module Structure

Every feature module must use these folders:

```text
Features/<ModuleName>/
  Model/
  View/
  Controller/
  ViewModel/
```

Use `.gitkeep` for an empty layer folder when the module does not need files in that layer yet.

## Layer Responsibilities

### Model

Owns feature data contracts and feature-specific services.

Allowed:

- Request and response DTOs.
- Domain models owned by the feature.
- Feature service protocols and service implementations.
- Endpoint declarations for that feature.

Avoid:

- UIKit imports.
- Navigation decisions.
- View state rendering.

### View

Owns UIKit view composition only.

Allowed:

- `UIView` subclasses.
- UI control creation and layout.
- Reusable feature-local view components.

Avoid:

- Network calls.
- Business rules.
- Navigation decisions.
- Direct dependencies on services.

### ViewModel

Owns presentation state and user intent handling.

Allowed:

- Input validation orchestration.
- Calling feature services.
- Mapping service results to observable view state.
- Logging meaningful feature events.

Avoid:

- UIKit imports.
- Pushing or presenting view controllers.
- Reading text fields or mutating views directly.

### Controller

Owns UIKit lifecycle, view binding, and navigation callbacks.

Allowed:

- `UIViewController` subclasses.
- Binding view model state into views.
- Reading user input from views and forwarding intents to view models.
- Calling coordinator callbacks.

Avoid:

- Direct network calls.
- Persistence access.
- Business logic that belongs in view models or services.

## Dependency Flow

```text
Controller -> View
Controller -> ViewModel -> Model service protocol -> service implementation -> Core
Application coordinator -> Controller
Application container -> ViewModel dependencies
```

Controllers should not construct service implementations. The app container wires dependencies and exposes view model factories.

## Current Modules

```text
Features/Auth/
  Model/AuthService.swift
  View/LoginView.swift
  View/RegisterView.swift
  View/ForgotPasswordView.swift
  Controller/LoginViewController.swift
  Controller/RegisterViewController.swift
  Controller/ForgotPasswordViewController.swift
  ViewModel/LoginViewModel.swift
  ViewModel/RegisterViewModel.swift
  ViewModel/ForgotPasswordViewModel.swift

Features/Home/
  Model/.gitkeep
  View/.gitkeep
  Controller/HomeViewController.swift
  ViewModel/HomeViewModel.swift
```

## Naming Rules

- Models and services: `<Feature>Service`, `<Feature>Endpoint`, `<Feature>Request`, `<Feature>Response`.
- Views: `<Screen>View`.
- View models: `<Screen>ViewModel`.
- Controllers: `<Screen>ViewController`.
- Tests: keep view model and service tests focused on state transitions and data mapping.
