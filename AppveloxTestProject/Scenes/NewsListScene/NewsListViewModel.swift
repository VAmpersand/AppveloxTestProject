final class NewsListViewModel {

    var router: NewsListRouterProtocol!
    var parentRouter: Router!

    weak var controller: NewsListControllerProtocol?
}

// MARK: - NewsListViewModelProtocol
extension NewsListViewModel: NewsListViewModelProtocol {
    func presentNewsInfoScene() {
        router.presentNewsInfoScene()
    }
}
