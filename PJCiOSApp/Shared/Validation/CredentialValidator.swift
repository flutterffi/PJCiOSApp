import Foundation

struct CredentialValidator {
    func validate(email: String, password: String) -> Result<Void, ValidationError> {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        guard trimmedEmail.contains("@"), trimmedEmail.contains(".") else {
            return .failure(.invalidEmail)
        }

        guard password.count >= 6 else {
            return .failure(.weakPassword)
        }

        return .success(())
    }
}

enum ValidationError: LocalizedError, Equatable {
    case invalidEmail
    case weakPassword

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return L10n.Validation.invalidEmail
        case .weakPassword:
            return L10n.Validation.weakPassword
        }
    }
}
