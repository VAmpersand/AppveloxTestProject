final class NewsInfoViewModel {

    var router: NewsInfoRouterProtocol!
    var parentRouter: Router!

    weak var controller: NewsInfoControllerProtocol?
}

// MARK: - NewsInfoViewModelProtocol
 extension NewsInfoViewModel: NewsInfoViewModelProtocol {
    func handleClose() {
        router.handleClose()
    }
}
