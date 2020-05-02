import UIKit

extension UIApplication {
    func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            return
        }
    }
}
