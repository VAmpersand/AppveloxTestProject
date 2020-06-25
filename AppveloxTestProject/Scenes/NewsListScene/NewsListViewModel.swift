import UIKit

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
    func updateNewsList() {
        self.dependencies.networkService.loadRSS(complition: { newsList in
            self.controller?.setupNewsList(newsList)
            self.controller?.updateCategoriesList(for: newsList)
        })
    }
    
    func presentNewsInfoScene(with news: News) {
        router.presentNewsInfoScene(with: news)
    }
}
