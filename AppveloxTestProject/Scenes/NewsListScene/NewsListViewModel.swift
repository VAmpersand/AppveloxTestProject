final class NewsListViewModel {

    var router: NewsListRouterProtocol!
    var parentRouter: Router!

    weak var controller: NewsListControllerProtocol?
//
//    private let dependencies: NewsListViewModelDependencyResolver
//
//    init(injecting dependencies: NewsListViewModelDependencyResolver) {
//        self.dependencies = dependencies
//    }
}

// MARK: - NewsListViewModelProtocol
extension NewsListViewModel: NewsListViewModelProtocol {
    func presentNewsInfoScene() {
        router.presentNewsInfoScene()
    }
    

}
