import UIKit

@IBDesignable
class UnderlinedButton: UIButton {

    var _attributedString = ""

    @IBInspectable
    var attributedString: String = "" {
        willSet {
            _attributedString = newValue
        }
    }

    @IBInspectable
    var underline: Bool = false {
        didSet {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 15),
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
            let string = NSMutableAttributedString(string: _attributedString, attributes: attributes)
            self.setAttributedTitle(string, for: .normal)
        }
    }
}
