import UIKit

protocol FormStateRendering: AnyObject {
    var formControls: [UIControl] { get }
    var formMessageLabel: UILabel { get }
    var formActivityIndicator: UIActivityIndicatorView { get }
}

extension FormStateRendering {
    func renderFormState(isLoading: Bool, message: String) {
        formControls.forEach { control in
            control.isEnabled = !isLoading
        }

        formMessageLabel.text = message

        if isLoading {
            formActivityIndicator.startAnimating()
        } else {
            formActivityIndicator.stopAnimating()
        }
    }
}
