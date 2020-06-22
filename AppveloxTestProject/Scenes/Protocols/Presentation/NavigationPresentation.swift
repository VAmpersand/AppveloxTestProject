import UIKit

final class NavigationPresentation {
    struct Options {
        let isBarHidden: Bool
    }

    private let options: Options

    init(options: Options = .init(isBarHidden: true)) {
        self.options = options
    }
}

// MARK: - Presentation
extension NavigationPresentation: Presentation {
    func present(_ controller: UIViewController,
                 from parentController: UIViewController,
                 animated: Bool,
                 completion: (() -> Void)?) {

        var navigationController: UINavigationController?

        if let parentNavigationControllerAsNavigationController = (parentController as? UINavigationController) {
            navigationController = parentNavigationControllerAsNavigationController
        } else if let parentNavigationController = parentController.navigationController {
            navigationController = parentNavigationController
        }

        guard let navController = navigationController else {
            assertionFailure("Parent Controller should be embedded in navigation controller")
            return
        }

        navController.pushViewController(controller, animated: animated)
        completion?()
    }

    func dismiss(from router: Router, to parentRouter: Router?, animated: Bool, completion: (() -> Void)?) {
        guard let navigationController = router.controller?.navigationController else {
            assertionFailure("Parent Controller should be embedded in navigation controller")
            return
        }

        navigationController.popViewController(animated: animated)
        completion?()
    }
}
