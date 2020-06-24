import AlamofireRSSParser

final class NewsInfoScene: BaseScene {

    // weaver: parentRouter <= Router

    // weaver: newsInfoRouter = NewsInfoRouter
    // weaver: newsInfoRouter.scope = .transient

    // weaver: newsInfoViewModel = NewsInfoViewModel
    // weaver: newsInfoViewModel.scope = .transient

    // weaver: newsInfoController = NewsInfoController
    // weaver: newsInfoController.scope = .transient
    
    // weaver: news <= RSSFeed

    init(injecting dependencies: NewsInfoSceneDependencyResolver) {
        let router = dependencies.newsInfoRouter
        let viewModel = dependencies.newsInfoViewModel(news: dependencies.news)
        let controller = dependencies.newsInfoController

        controller.viewModel = viewModel
        viewModel.router = router
        viewModel.parentRouter = dependencies.parentRouter
        viewModel.controller = controller

        super.init(viewController: controller,
                   router: router,
                   parentRouter: dependencies.parentRouter)
    }
}
