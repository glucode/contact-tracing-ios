import Foundation
import UserNotifications

class NotificationManager {

    static let shared = NotificationManager()
    private let notificationCenter = UNUserNotificationCenter.current()

    init() {}

    func requestAuthorisation(completion: @escaping ((Bool, Error?) -> Void)) {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        notificationCenter.requestAuthorization(options: options) { (granted, error) in
            if error != nil {
                completion(false, error)
            } else {
                completion(granted, nil)
            }
        }
    }

    func authorisationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        notificationCenter.getNotificationSettings { (settings) in
            completion(settings.authorizationStatus)
        }
    }

    func test() {
    }

}
