import UIKit

class OnboardingMainViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        insertCountryName()
    }

    var countryData: [String]? {
        guard let path = Bundle.main.path(forResource: "CountryName", ofType: "plist") else { return nil}
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        guard let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String] else { return nil }
        return plist
    }

    func insertCountryName() {
        let welcomeText = welcomeLabel.text
        guard let country = countryData?[0] else { return }
        let newWelcomeText = welcomeText?.replacingOccurrences(of: "[$Country]", with: country)
        welcomeLabel.text = newWelcomeText
    }

}
