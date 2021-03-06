import Foundation
import UIKit

/**
 A UIAlertController with a single text field input, and an OK and Cancel action. The OK button is disabled
 when the text box is empty or whitespace.
 */
class TextBoxAlertController: UIAlertController {
    
    var textValidator: ((String?) -> Bool)?
    
    convenience init(title: String, message: String? = nil, initialValue: String? = nil, placeholder: String? = nil,
                     textValidator: ((String?) -> Bool)? = nil, onOK: @escaping (String?) -> ()) {
        self.init(title: title, message: message, preferredStyle: .alert)
        self.textValidator = textValidator
        
        addTextField{ [unowned self] textField in
            textField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
            textField.autocapitalizationType = .words
            textField.placeholder = placeholder
            textField.text = initialValue
        }
        
        addAction(UIAlertAction(title: "Cancel", style: .cancel))
        let okAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            onOK(self.textFields![0].text)
        }
        
        okAction.isEnabled = textValidator?(initialValue) ?? true
        addAction(okAction)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        actions[1].isEnabled = textValidator?(textField.text) ?? true
    }
}
