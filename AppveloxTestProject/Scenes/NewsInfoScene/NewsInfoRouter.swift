final class NewsInfoRouter: BaseRouter {

}

// MARK: - NewsInfoRouterProtocol
extension NewsInfoRouter: NewsInfoRouterProtocol {
    func handleClose() {
        dismissSelf(using: PopoverPresentation())
    }
}
