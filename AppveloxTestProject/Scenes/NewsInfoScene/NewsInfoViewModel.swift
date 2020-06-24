final class NewsInfoViewModel {
    
    // weaver: news <= Item

    var router: NewsInfoRouterProtocol!
    var parentRouter: Router!
    
    weak var controller: NewsInfoControllerProtocol?
    private let dependencies: NewsInfoViewModelDependencyResolver
    init(injecting dependencies: NewsInfoViewModelDependencyResolver) {
        self.dependencies = dependencies
    }
}

// MARK: - NewsInfoViewModelProtocol
 extension NewsInfoViewModel: NewsInfoViewModelProtocol {
    func handleClose() {
        router.handleClose()
    }
}
