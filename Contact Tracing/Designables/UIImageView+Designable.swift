import UIKit

@IBDesignable
class DesignableImageView: UIImageView {
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable
    var fullyRounded: Bool = false {
        didSet {
            if fullyRounded {
                layer.cornerRadius = layer.bounds.height / 2
            } else {
                layer.cornerRadius = 0
            }
        }
    }
}
