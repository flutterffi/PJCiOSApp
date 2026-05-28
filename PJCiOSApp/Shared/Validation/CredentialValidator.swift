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
            return "Please enter a valid email address."
        case .weakPassword:
            return "Password must be at least 6 characters."
        }
    }
}
