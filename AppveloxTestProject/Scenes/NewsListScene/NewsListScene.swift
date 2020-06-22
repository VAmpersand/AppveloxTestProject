final class NewsListScene: BaseScene {

    // weaver: parentRouter <= Router

    // weaver: newsListRouter = NewsListRouter
    // weaver: newsListRouter.scope = .transient

    // weaver: newsListViewModel = NewsListViewModel
    // weaver: newsListViewModel.scope = .transient

    // weaver: newsListController = NewsListController
    // weaver: newsListController.scope = .transient

    init(injecting dependencies: NewsListSceneDependencyResolver) {
        let router = dependencies.newsListRouter
        let viewModel = dependencies.newsListViewModel
        let controller = dependencies.newsListController

        controller.viewModel = viewModel
        viewModel.router = router
        viewModel.parentRouter = dependencies.parentRouter
        viewModel.controller = controller

        super.init(viewController: controller,
                   router: router,
                   parentRouter: dependencies.parentRouter,
                   embeddationStyle: .navigation)
    }
}

