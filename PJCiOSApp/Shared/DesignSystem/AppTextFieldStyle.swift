import UIKit

enum AppTextFieldStyle {
    static func apply(to textField: UITextField) {
        textField.borderStyle = .none
        textField.backgroundColor = AppColor.fieldBackground
        textField.font = AppFont.body
        textField.textColor = AppColor.textPrimary
        textField.layer.cornerRadius = AppRadius.control
        textField.layer.borderWidth = 1
        textField.layer.borderColor = AppColor.fieldBorder.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: AppSpacing.medium, height: 1))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: AppSpacing.medium, height: 1))
        textField.rightViewMode = .always
    }
}
