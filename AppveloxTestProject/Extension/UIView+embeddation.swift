import UIKit

public extension UIViewController {
    func embeddedInNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)

        return navigationController
    }

    func embeddedInHiddenNavigationController() -> UINavigationController {
        let navigationController = embeddedInNavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)

        return navigationController
    }
}
