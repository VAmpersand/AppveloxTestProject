final class NewsListViewModel {
    
    // weaver: networkService = NetworkService

    var router: NewsListRouterProtocol!
    var parentRouter: Router!

    weak var controller: NewsListControllerProtocol?
    
    private let dependencies: NewsListViewModelDependencyResolver
    init(injecting dependencies: NewsListViewModelDependencyResolver) {
        self.dependencies = dependencies
    }
}

// MARK: - NewsListViewModelProtocol
extension NewsListViewModel: NewsListViewModelProtocol {
    func viewDidLoad() {
        dependencies.networkService.loadRSS(complition: { newsList in
            self.controller?.setupNewsList(newsList)
        })
    }
    
    func presentNewsInfoScene(with news: Item) {
        router.presentNewsInfoScene(with: news)
    }
}
